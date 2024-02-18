#!/usr/bin/env python3

import multiprocessing as mp
import multiprocessing.managers
import multiprocessing.synchronize
import select
import socket
import struct
import threading
import time
from dataclasses import dataclass
from typing import Any, cast

import click
import matplotlib.animation
import matplotlib.container
import matplotlib.pyplot as plt
import numpy as np
import numpy.typing as npt


@dataclass
class ProgramArguments(object):
    port: int
    traceLength: int
    statisticalValue: float
    yBound: float

    @classmethod
    def fromDict(cls, options: dict[str, Any]):
        return cls(
            port=options["port"],
            traceLength=options["trace_length"],
            statisticalValue=options["statistical_value"],
            yBound=options["y_bound"],
        )


@dataclass
class SharedState(object):
    stop: threading.Event
    mem: Any


class Scope(object):
    def __init__(
        self,
        axs: plt.Axes,
        data: npt.NDArray[np.float64],
        statisticalValue: float,
        yBound: float,
    ) -> None:
        self.axs = axs

        length = len(data)
        self.data = data

        self.axs.axhline(statisticalValue, color="r")  # type: ignore

        xAxis = np.arange(0, length, 1)  # type: ignore
        self.stem = self.axs.stem(  # type: ignore
            xAxis,  # type: ignore
            self.data,
            markerfmt="none",
            basefmt="none",
        )

        # Pre-compute stems
        self.stems = np.zeros(shape=(length, 2, 2), dtype=np.float64)  # type: ignore
        self.stems[:, 0, 0] = xAxis  # type: ignore
        self.stems[:, 1, 0] = xAxis  # type: ignore

        self.axs.set_xlim(0, length)
        self.axs.set_ylim(0, yBound)

    def update(self, _: Any) -> tuple[matplotlib.container.StemContainer]:
        self.stems[:, 1, 1] = self.data  # type: ignore

        self.stem.stemlines.set_paths(self.stems)  # type: ignore
        return (self.stem,)


def serverProcess(args: ProgramArguments, state: SharedState) -> None:
    tvals = np.frombuffer(state.mem, dtype=np.float64)  # type: ignore

    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as serverSock:
        serverSock.bind(("0.0.0.0", args.port))

        while True:
            if state.stop.is_set():
                return

            ready = select.select([serverSock], [], [], 0.5)
            if not ready[0]:
                continue

            message = serverSock.recv(2048)

            # Format is: start index, number of samples, values...
            # Indices wrap to 0, like a circular buffer
            startIndex, nSamples = struct.unpack("<II", message[0:8])
            values = list(x[0] for x in struct.iter_unpack("<d", message[8:]))

            if startIndex + nSamples <= args.traceLength:
                tvals[startIndex : startIndex + nSamples] = values
            else:
                firstChunkSize = args.traceLength - startIndex
                tvals[startIndex : args.traceLength] = values[:firstChunkSize]
                tvals[0 : nSamples - firstChunkSize] = values[firstChunkSize:]


def plotProcess(args: ProgramArguments, state: SharedState) -> None:
    tvals = cast(npt.NDArray[np.float64], np.frombuffer(state.mem, dtype=np.float64))  # type: ignore

    fig, axs = plt.subplots()  # type: ignore
    scope = Scope(axs, tvals, args.statisticalValue, args.yBound)

    _ = matplotlib.animation.FuncAnimation(fig, scope.update, interval=16, blit=False)
    plt.show()  # type: ignore


@click.command(name="realtime_scope_client")
@click.option("--port", help="Port to listen to.", type=int, default=31671)
@click.option(
    "--trace-length", help="How many samples per trace.", type=int, default=8500
)
@click.option(
    "--statistical-value",
    help="The Y-value to draw a red line.",
    type=float,
    default=4.5,
)
@click.option(
    "--y-bound",
    help="The Y-value to set as the top the plot window.",
    type=float,
    default=10,
)
def main(**kwargs: dict[str, Any]) -> None:
    args = ProgramArguments.fromDict(kwargs)

    with multiprocessing.Manager() as manager:
        state = SharedState(manager.Event(), mp.RawArray("b", args.traceLength * 8))

        # Create and start processes
        procDefs = (serverProcess, plotProcess)
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
