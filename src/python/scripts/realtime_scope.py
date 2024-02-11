#!/usr/bin/env python3

import enum
import multiprocessing as mp
import socket
import struct
import time
from dataclasses import dataclass
from types import TracebackType
from typing import Any, Literal

import click
import numpy as np
from pyTVLA.datasource import ChipWhispererDataSource, RandomDataSource
from pyTVLA.engine import SoftwareEngine
from pyTVLA.pynq_engine import PynqEngine
from pyTVLA.scheduler import FixedRandomScheduler
from pyTVLA.storage import HistogramStorage

try:
    import pynq

    _pynq_available = True
except ImportError:
    _pynq_available = False

KEY = b"1234567812345678"
TEXTS = (
    b"AbcdAbcdAbcdAbcd",
    b"zxczxczxczxczxcz",
    b"alighagiagnnwnfg",
    b"hkiwknjcwyjnklas",
)


class MemoryType(enum.Enum):
    histA = 0
    histB = 1
    tvals = 2


@dataclass
class SharedMemory(object):
    __array_interface__: Any
    memoryObj: Any

    def asArray(self) -> Any:
        return np.array(self, copy=False)  # type: ignore


class MemoryManager(object):
    """Storage class of all shared memory."""

    def __init__(self, traceLen: int) -> None:
        self._traceLen = traceLen
        self._mems: dict[MemoryType, SharedMemory] = {}

    def _createMem(
        self, memType: MemoryType, byteSize: int, shape: tuple[int, ...], dtype: Any
    ) -> None:
        if memType in self._mems:
            raise RuntimeError(f"Memory type already created: {memType}")

        if _pynq_available:
            buf = pynq.allocate(shape=shape, dtype=dtype)  # type:ignore
            interface = buf.__array_interface__  # type:ignore
            self._mems[memType] = SharedMemory(interface, buf)
        else:
            buf = mp.RawArray("b", byteSize)
            arr = np.frombuffer(buf, dtype=dtype)  # type:ignore
            arr.shape = shape
            interface = arr.__array_interface__  # type:ignore
            self._mems[memType] = SharedMemory(interface, buf)
        pass

    def __enter__(self):
        self._createMem(
            MemoryType.histA, self._traceLen * 256 * 4, (self._traceLen, 256), np.uint32
        )
        self._createMem(
            MemoryType.histB, self._traceLen * 256 * 4, (self._traceLen, 256), np.uint32
        )
        self._createMem(
            MemoryType.tvals, self._traceLen * 8, (self._traceLen,), np.float64
        )

        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        if _pynq_available:
            for b in self._mems.values():
                b.memoryObj.freebuffer()

    def getConfig(self, memType: MemoryType) -> SharedMemory:
        return self._mems[memType]


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


def ingestProcess(args: ProgramArguments, mem: MemoryManager) -> None:
    """Gets new traces and stores them in histograms."""

    histMemA = mem.getConfig(MemoryType.histA).asArray()
    histMemB = mem.getConfig(MemoryType.histB).asArray()
    store = HistogramStorage(args.traceLength, histMemA, histMemB, np.uint16)

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
            tType, trace = ds.next()
            store.ingest(trace, tType)

            if decimationPhase == 0 and args.decimationFreq != -1:
                store.decimate()
            decimationPhase = (decimationPhase + 1) % args.decimationFreq

            time.sleep(args.datasourceDelay)


def computeProcess(args: ProgramArguments, mem: MemoryManager) -> None:
    """Calculates the t values."""

    histMemA = mem.getConfig(MemoryType.histA)
    histMemB = mem.getConfig(MemoryType.histB)
    tvals = mem.getConfig(MemoryType.tvals)

    tvalsBuf = mem.getConfig(MemoryType.tvals).asArray()

    # create engine
    if args.engine == "software":
        engine = SoftwareEngine(histMemA.asArray(), histMemB.asArray(), tvals.asArray())
    elif args.engine == "pynq":
        if _pynq_available:
            engine = PynqEngine(
                args.traceLength,
                histMemA.memoryObj,
                histMemB.memoryObj,
                tvals.memoryObj,
            )
        else:
            raise RuntimeError("Unable to use PynqEngine without pynq module.")
    else:
        raise NotImplementedError

    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as clientSocket, engine:
        addr = (args.viewerAddress, args.port)
        while True:
            # Calculate entire trace
            nSamples = 0
            while nSamples < args.samplesPerUpdate:
                start, end = engine.calculate()
                nSamples += end - start

            # Send in chunks
            for i in range(0, args.traceLength, args.samplesPerUpdate):
                chunk = tvalsBuf[i : i + args.samplesPerUpdate]
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
    with MemoryManager(args.traceLength) as mem:
        # Create and start processes
        procDefs = (ingestProcess, computeProcess)
        processes = [mp.Process(target=p, args=(args, mem)) for p in procDefs]

        for p in processes:
            p.start()

        try:
            while True:
                if any(not p.is_alive() for p in processes):
                    break
                time.sleep(1)
        except KeyboardInterrupt:
            print("Terminating processes.")

        # Terminate processes
        for p in processes:
            p.terminate()
        for p in processes:
            p.join()


if __name__ == "__main__":
    main()
