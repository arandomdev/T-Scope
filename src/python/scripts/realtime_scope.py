#!/usr/bin/env python3

import enum
import multiprocessing as mp
from dataclasses import dataclass
from types import TracebackType
from typing import Any, Literal

import click
import matplotlib.animation
import matplotlib.container
import matplotlib.lines
import matplotlib.pyplot as plt
import numpy as np
import numpy.typing as npt
from pyTVLA.datasource import ChipWhispererDataSource, RandomDataSource
from pyTVLA.engine import SoftwareEngine
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


class MemoryType(enum.Enum):
    histA = 0
    histB = 1
    tvals = 2


@dataclass
class MemoryConfig(object):
    __array_interface__: dict[str, Any]
    physAddr: int | None

    def asArray(self) -> Any:
        return np.array(self, copy=False)  # type: ignore


MemoryStore = dict[MemoryType, MemoryConfig]


class MemoryManager(object):
    """Storage class of all shared memory."""

    def __init__(self, traceLen: int) -> None:
        self._traceLen = traceLen

    def __enter__(self):
        if _pynq_available:
            bufHistA = pynq.allocate(shape=(self._traceLen, 256), dtype=np.uint32)  # type:ignore
            bufHistB = pynq.allocate(shape=(self._traceLen, 256), dtype=np.uint32)  # type:ignore
            bufTvals = pynq.allocate(shape=(self._traceLen,), dtype=np.float64)  # type:ignore

            arrIntHistA = bufHistA.__array_interface__  # type:ignore
            arrIntHistB = bufHistB.__array_interface__  # type:ignore
            arrIntTvals = bufTvals.__array_interface__  # type:ignore

            self._pynqBuffers: dict[MemoryType, pynq.buffer.PynqBuffer] = {  # type:ignore
                MemoryType.histA: bufHistA,
                MemoryType.histB: bufHistB,
                MemoryType.tvals: bufTvals,
            }
        else:
            bufHistA = mp.Array("b", self._traceLen * 256 * 4, lock=False)
            bufHistB = mp.Array("b", self._traceLen * 256 * 4, lock=False)
            bufTvals = mp.Array("b", self._traceLen * 8, lock=False)

            arrHistA = np.frombuffer(bufHistA, dtype=np.uint32)  # type: ignore
            arrHistB = np.frombuffer(bufHistB, dtype=np.uint32)  # type: ignore
            arrTvals = np.frombuffer(bufTvals, dtype=np.float64)  # type: ignore

            arrHistA.shape = (self._traceLen, 256)
            arrHistB.shape = (self._traceLen, 256)
            arrTvals.shape = (self._traceLen,)

            arrIntHistA = arrHistA.__array_interface__  # type:ignore
            arrIntHistB = arrHistB.__array_interface__  # type:ignore
            arrIntTvals = arrTvals.__array_interface__  # type:ignore

            self._buffers: tuple[Any, ...] = (bufHistA, bufHistB, bufTvals)

        self._mems = {
            MemoryType.histA: MemoryConfig(
                arrIntHistA,  # type: ignore
                (
                    self._buffers[MemoryType.histA].physical_address  # type: ignore
                    if _pynq_available
                    else None
                ),
            ),
            MemoryType.histB: MemoryConfig(
                arrIntHistB,  # type: ignore
                (
                    self._buffers[MemoryType.histB].physical_address  # type: ignore
                    if _pynq_available
                    else None
                ),
            ),
            MemoryType.tvals: MemoryConfig(
                arrIntTvals,  # type: ignore
                (
                    self._buffers[MemoryType.tvals].physical_address  # type: ignore
                    if _pynq_available
                    else None
                ),
            ),
        }

        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        if _pynq_available:
            for b in self._pynqBuffers.values():
                b.freebuffer()

    def getConfigs(self) -> MemoryStore:
        return self._mems


@dataclass
class ProgramArguments(object):
    traceLength: int
    datasource: Literal["random", "chipwhisperer"]
    decimationFreq: int
    statisticalValue: float
    yBound: float

    @classmethod
    def fromDict(cls, options: dict[str, Any]):
        return cls(
            traceLength=options["trace_length"],
            datasource=options["datasource"],
            decimationFreq=options["decimation_freq"],
            statisticalValue=options["statistical_value"],
            yBound=options["y_bound"],
        )


def ingestProcess(args: ProgramArguments, mem: MemoryStore) -> None:
    """Gets new traces and stores them in histograms."""

    histMemA = mem[MemoryType.histA].asArray()
    histMemB = mem[MemoryType.histB].asArray()
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


def computeProcess(args: ProgramArguments, mem: MemoryStore) -> None:
    """Calculates the t values."""

    histMemA = mem[MemoryType.histA].asArray()
    histMemB = mem[MemoryType.histB].asArray()
    tvals = mem[MemoryType.tvals].asArray()

    engine = SoftwareEngine(histMemA, histMemB, tvals)
    while True:
        engine.calculate()


def plotProcess(args: ProgramArguments, mem: MemoryStore) -> None:
    tvals = mem[MemoryType.tvals].asArray()

    fig, axs = plt.subplots()  # type: ignore
    scope = Scope(axs, tvals, args.statisticalValue, args.yBound)

    _ = matplotlib.animation.FuncAnimation(fig, scope.update, interval=16, blit=False)
    plt.show()  # type: ignore


@click.command(name="realtime_scope")
@click.option(
    "--trace-length", help="How many samples per trace", type=int, default=5000
)
@click.option(
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
@click.option(
    "--y-bound",
    help="The Y-value to set as the top the plot window.",
    type=float,
    default=10,
)
def main(**kwargs: dict[str, Any]) -> None:
    args = ProgramArguments.fromDict(kwargs)
    with MemoryManager(args.traceLength) as mem:
        # Create and start processes
        procDefs = (
            ingestProcess,
            computeProcess,
            plotProcess,
        )
        processes = [
            mp.Process(target=p, args=(args, mem.getConfigs())) for p in procDefs
        ]

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
