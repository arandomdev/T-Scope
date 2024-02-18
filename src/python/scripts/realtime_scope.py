#!/usr/bin/env python3

import multiprocessing as mp
import socket
import struct
import threading
import time
from dataclasses import dataclass
from typing import Any, Literal

import click
import numpy as np
from pyTVLA.datasource import ChipWhispererDataSource, RandomDataSource
from pyTVLA.engine import SoftwareEngine
from pyTVLA.memory import HistogramStorage, MemoryManager, SoftwareMemoryManager
from pyTVLA.pynq import PynqEngine, PynqMemoryManager
from pyTVLA.scheduler import FixedRandomScheduler
from pyTVLA.types import MemoryType

KEY = b"1234567812345678"
TEXTS = (
    b"AbcdAbcdAbcdAbcd",
    b"zxczxczxczxczxcz",
    b"alighagiagnnwnfg",
    b"hkiwknjcwyjnklas",
)


@dataclass
class SharedState(object):
    stop: threading.Event
    memoryManager: MemoryManager


@dataclass
class ProgramArguments(object):
    viewerAddress: str
    port: int
    traceLength: int
    datasource: Literal["random", "chipwhisperer"]
    engine: Literal["software", "pynq"]
    decimationFreq: int
    datasourceDelay: float
    engineDelay: float
    samplesPerUpdate: int

    @classmethod
    def fromDict(cls, options: dict[str, Any]):
        return cls(
            viewerAddress=options["viewer_address"],
            port=options["port"],
            traceLength=options["trace_length"],
            datasource=options["datasource"],
            engine=options["engine"],
            decimationFreq=options["decimation_freq"],
            datasourceDelay=options["datasource_delay"],
            engineDelay=options["engine_delay"],
            samplesPerUpdate=options["samples_per_update"],
        )


def ingestProcess(args: ProgramArguments, state: SharedState) -> None:
    """Gets new traces and stores them in histograms."""

    store = HistogramStorage(state.memoryManager, np.uint16)

    if args.datasource == "random":
        dsInst = RandomDataSource(args.traceLength, np.uint16)
    elif args.datasource == "chipwhisperer":
        sch = FixedRandomScheduler(KEY, 16, TEXTS)
        dsInst = ChipWhispererDataSource(args.traceLength, sch, np.uint16)
    else:
        raise NotImplementedError

    with dsInst as ds:
        decimationPhase = 0

        while True:
            # Check stop flag
            if state.stop.is_set():
                return

            # Get next trace
            tType, trace = ds.next()
            store.ingest(trace, tType)

            if decimationPhase == 0 and args.decimationFreq != -1:
                store.decimate()
            decimationPhase = (decimationPhase + 1) % args.decimationFreq

            time.sleep(args.datasourceDelay)


def computeProcess(args: ProgramArguments, state: SharedState) -> None:
    """Calculates the t values."""

    # create engine
    if args.engine == "software":
        assert type(state.memoryManager) is SoftwareMemoryManager
        engine = SoftwareEngine(state.memoryManager)
        dtype = np.float64
    elif args.engine == "pynq":
        assert type(state.memoryManager) is PynqMemoryManager
        engine = PynqEngine(state.memoryManager)
        dtype = np.float64
    else:
        raise NotImplementedError

    tvals = state.memoryManager.getArray(MemoryType.tvals, dtype)

    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as clientSocket:
        addr = (args.viewerAddress, args.port)
        while True:
            # Check stop flag
            if state.stop.is_set():
                return

            # Calculate entire trace
            nSamples = 0
            while nSamples < args.samplesPerUpdate:
                start, end = engine.calculate()
                nSamples += end - start

            # Send in chunks
            for i in range(0, args.traceLength, args.samplesPerUpdate):
                chunk = tvals[i : i + args.samplesPerUpdate]
                data = struct.pack("<II", i, len(chunk))
                data += struct.pack(
                    f"<{len(chunk)}d",
                    *chunk,
                )
                clientSocket.sendto(data, addr)

            time.sleep(args.engineDelay)


@click.command(name="realtime_scope")
@click.argument("viewer_address", type=str)
@click.option("--port", help="Port of the viewer host.", type=int, default=31671)
@click.option(
    "--trace-length", help="How many samples per trace.", type=int, default=5000
)
@click.option(
    "--datasource",
    help="The datasource to use.",
    type=click.Choice(["random", "chipwhisperer"], case_sensitive=False),
    default="random",
)
@click.option(
    "--engine",
    help="The engine to use.",
    type=click.Choice(["software", "pynq"], case_sensitive=False),
    default="software",
)
@click.option(
    "--decimation-freq",
    help="How many traces should be ingested before decimation by 2. Set to -1 to disable.",
    type=int,
    default=50,
)
@click.option(
    "--datasource-delay",
    help="How long to wait in seconds between getting samples from the datasource.",
    type=float,
    default=0.1,
)
@click.option(
    "--engine-delay",
    help="How long to wait in seconds between calculating a new t-test trace.",
    type=float,
    default=0.5,
)
@click.option(
    "--samples-per-update",
    help="The number of samples a update should contain when sent to the viewer.",
    type=int,
    default=60,
)
def main(**kwargs: dict[str, Any]) -> None:
    args = ProgramArguments.fromDict(kwargs)

    if args.engine == "software":
        memManType = SoftwareMemoryManager
    elif args.engine == "pynq":
        memManType = PynqMemoryManager
    else:
        raise NotImplementedError

    with mp.Manager() as manager, memManType(args.traceLength) as memManager:
        state = SharedState(manager.Event(), memManager)

        # Create and start processes
        procDefs = (ingestProcess, computeProcess)
        processes = [
            mp.Process(target=p, args=(args, state), name=p.__name__) for p in procDefs
        ]

        for p in processes:
            p.start()

        try:
            while True:
                if any(not p.is_alive() for p in processes):
                    break

                time.sleep(1)
        except KeyboardInterrupt:
            pass

        # Stop processes
        print("Stopping processes.")
        state.stop.set()
        for p in processes:
            p.join(2)

        # Terminate processes
        for p in processes:
            if p.is_alive():
                p.terminate()
                print(f"Needed to terminating {p.name}")
        for p in processes:
            p.join()


if __name__ == "__main__":
    main()
