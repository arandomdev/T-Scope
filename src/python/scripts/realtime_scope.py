#!/usr/bin/env python3

import multiprocessing as mp
from typing import Any

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
    def __init__(self, axs: plt.Axes, data: npt.NDArray[ELEMENT_TYPE]) -> None:
        self.axs = axs

        length = len(data)
        self.data = data

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


def dataProcess(sharedMem: Any) -> None:
    data = np.frombuffer(sharedMem, dtype=ELEMENT_TYPE)  # type: ignore

    scheduler = pyTVLA.scheduler.FixedRandomScheduler(KEY, 16, TEXTS)
    with pyTVLA.datasource.ChipWhispererDataSource(
        TRACE_LENGTH, scheduler, np.uint16
    ) as ds:
        engine = pyTVLA.engine.SoftwareEngine(TRACE_LENGTH, np.uint16)

        while True:
            tType, trace = ds.next()
            engine.ingest(trace, tType)
            data[:] = engine.calculate()


def plotProcess(sharedMem: Any) -> None:
    data = np.frombuffer(sharedMem, dtype=ELEMENT_TYPE)  # type: ignore

    fig, axs = plt.subplots()  # type: ignore
    scope = Scope(axs, data)  # type: ignore

    _ = matplotlib.animation.FuncAnimation(fig, scope.update, interval=0, blit=False)
    plt.show()  # type: ignore


def main() -> None:
    sharedMem = mp.Array("b", TRACE_LENGTH * _ELEMENT_SIZE, lock=False)

    # Create and start processes
    processes = [
        mp.Process(target=plotProcess, args=(sharedMem,)),
        mp.Process(target=dataProcess, args=(sharedMem,)),
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
