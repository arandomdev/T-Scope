#!/usr/bin/env python3

import enum
import multiprocessing as mp
from dataclasses import dataclass
from typing import Any, Literal, Type

import click
import matplotlib.animation
import matplotlib.container
import matplotlib.lines
import matplotlib.pyplot as plt
import numpy as np
import numpy.typing as npt
import pyTVLA

TRACE_LENGTH = 5000  # Size of t-test trace
ELEMENT_TYPE = np.float64  # T-test trace element type
DEFAULT_LIMIT_Y = (0, 10)  # Default Y axis shown

_ELEMENT_SIZE = ELEMENT_TYPE().itemsize  # Size in bytes of the element type

KEY = b"1234567812345678"
TEXTS = (
    b"AbcdAbcdAbcdAbcd",
    b"zxczxczxczxczxcz",
    b"alighagiagnnwnfg",
    b"hkiwknjcwyjnklas",
)


class Scope(object):
    def __init__(
        self,
        axs: plt.Axes,
        data: npt.NDArray[ELEMENT_TYPE],
        statisticalValue: float,
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
        self.stems = np.zeros(shape=(length, 2, 2), dtype=ELEMENT_TYPE)  # type: ignore
        self.stems[:, 0, 0] = xAxis  # type: ignore
        self.stems[:, 1, 0] = xAxis  # type: ignore

        self.axs.set_xlim(0, length)
        self.axs.set_ylim(DEFAULT_LIMIT_Y[0], DEFAULT_LIMIT_Y[1])

    def update(self, _: Any) -> tuple[matplotlib.container.StemContainer]:
        self.stems[:, 1, 1] = self.data  # type: ignore

        self.stem.stemlines.set_paths(self.stems)  # type: ignore
        return (self.stem,)


class SharedMemoryType(enum.Enum):
    histA = 0
    histB = 1
    tvals = 2


@dataclass
class MemoryConfig(object):
    mem: Any
    dtype: Type[npt.DTypeLike]
    shape: tuple[int, ...]


class SharedMemoryStore(object):
    """Storage class of all shared memory."""

    def __init__(self, traceLen: int) -> None:
        self.mems = {
            SharedMemoryType.histA: MemoryConfig(
                mp.Array("b", traceLen * 256 * 4, lock=False),
                np.uint32,
                (traceLen, 256),
            ),
            SharedMemoryType.histB: MemoryConfig(
                mp.Array("b", traceLen * 256 * 4, lock=False),
                np.uint32,
                (traceLen, 256),
            ),
            SharedMemoryType.tvals: MemoryConfig(
                mp.Array("b", traceLen * _ELEMENT_SIZE, lock=False),
                np.float64,
                (traceLen,),
            ),
        }

    def getArray(self, type: SharedMemoryType) -> Any:
        config = self.mems[type]
        a = np.frombuffer(config.mem, dtype=config.dtype)  # type: ignore
        a.shape = config.shape
        return a  # type: ignore


@dataclass
class ProgramArguments(object):
    datasource: Literal["random", "chipwhisperer"]
    decimationFreq: int
    statisticalValue: float

    @classmethod
    def fromDict(cls, options: dict[str, Any]):
        return cls(
            datasource=options["datasource"],  # type: ignore
            decimationFreq=options["decimation_freq"],  # type: ignore
            statisticalValue=options["statistical_value"],  # type: ignore
        )


def ingestProcess(args: ProgramArguments, mem: SharedMemoryStore) -> None:
    """Gets new traces and stores them in histograms."""

    histMemA = mem.getArray(SharedMemoryType.histA)
    histMemB = mem.getArray(SharedMemoryType.histB)
    store = pyTVLA.storage.HistogramStorage(TRACE_LENGTH, histMemA, histMemB, np.uint16)

    if args.datasource == "random":
        dsInst = pyTVLA.datasource.RandomDataSource(TRACE_LENGTH, np.uint16)
    elif args.datasource == "chipwhisperer":
        sch = pyTVLA.scheduler.FixedRandomScheduler(KEY, 16, TEXTS)
        dsInst = pyTVLA.datasource.ChipWhispererDataSource(TRACE_LENGTH, sch, np.uint16)
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


def computeProcess(args: ProgramArguments, mem: SharedMemoryStore) -> None:
    """Calculates the t values."""

    histMemA = mem.getArray(SharedMemoryType.histA)
    histMemB = mem.getArray(SharedMemoryType.histB)
    tvals = mem.getArray(SharedMemoryType.tvals)

    engine = pyTVLA.engine.SoftwareEngine(histMemA, histMemB, tvals)
    while True:
        engine.calculate()


def plotProcess(args: ProgramArguments, mem: SharedMemoryStore) -> None:
    tvals = mem.getArray(SharedMemoryType.tvals)

    fig, axs = plt.subplots()  # type: ignore
    scope = Scope(axs, tvals, args.statisticalValue)  # type: ignore

    _ = matplotlib.animation.FuncAnimation(fig, scope.update, interval=16, blit=False)
    plt.show()  # type: ignore


@click.command(name="realtime_scope")
@click.option(
    "-d",
    "--datasource",
    help="The datasource to select.",
    type=click.Choice(["random", "chipwhisperer"], case_sensitive=False),
    default="random",
)
@click.option(
    "--decimation-freq",
    help="How many traces should be ingested before decimation by 2. Set to -1 to disable.",
    type=int,
    default=50,
)
@click.option(
    "--statistical-value",
    help="The Y-value to draw a red line.",
    type=float,
    default=4.5,
)
def main(**kwargs: dict[str, Any]) -> None:
    args = ProgramArguments.fromDict(kwargs)
    mem = SharedMemoryStore(TRACE_LENGTH)

    # Create and start processes
    procDefs = (
        ingestProcess,
        computeProcess,
        plotProcess,
    )
    processes = [mp.Process(target=p, args=(args, mem)) for p in procDefs]

    for p in processes:
        p.start()

    try:
        while True:
            if any(not p.is_alive() for p in processes):
                break
    except KeyboardInterrupt:
        print("Terminating processes.")

    # Terminate processes
    for p in processes:
        p.terminate()
    for p in processes:
        p.join()


if __name__ == "__main__":
    main()
