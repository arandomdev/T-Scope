import multiprocessing as mp
from typing import Any

import matplotlib.animation
import matplotlib.lines
import matplotlib.pyplot as plt
import numpy as np
import numpy.typing as npt
import pyTVLA

TRACE_LENGTH = 8192  # Size of t-test trace
ELEMENT_TYPE = np.float64  # T-test trace element type
DEFAULT_LIMIT_Y = (-8, 8)  # Default Y axis shown

_ELEMENT_SIZE = ELEMENT_TYPE().itemsize  # Size in bytes of the element type


class Scope(object):
    def __init__(self, axs: plt.Axes, data: npt.NDArray[ELEMENT_TYPE]) -> None:
        self.axs = axs

        length = len(data)
        self.data = data

        xAxis = np.arange(0, length, 1)  # type: ignore
        self.line = matplotlib.lines.Line2D(xAxis, self.data)  # type: ignore
        self.axs.add_line(self.line)
        self.axs.set_xlim(0, length)
        self.axs.set_ylim(DEFAULT_LIMIT_Y[0], DEFAULT_LIMIT_Y[1])
        pass

    def update(self, _: Any) -> tuple[matplotlib.lines.Line2D]:
        self.line.set_ydata(self.data)
        return (self.line,)


def dataProcess(sharedMem: Any) -> None:
    data = np.frombuffer(sharedMem, dtype=ELEMENT_TYPE)

    dataSourceA = pyTVLA.datasource.RandomDataSource(TRACE_LENGTH, 8)
    dataSourceB = pyTVLA.datasource.RandomDataSource(TRACE_LENGTH, 8)
    engine = pyTVLA.engine.SoftwareEngine(TRACE_LENGTH)

    while True:
        engine.ingest(True, dataSourceA.next())
        engine.ingest(False, dataSourceB.next())
        data[:] = engine.calculate()
        pass


def plotProcess(sharedMem: Any) -> None:
    data = np.frombuffer(sharedMem, dtype=ELEMENT_TYPE)

    fig, axs = plt.subplots()  # type: ignore
    scope = Scope(axs, data)

    _ = matplotlib.animation.FuncAnimation(fig, scope.update, interval=0, blit=False)
    plt.show()  # type: ignore


def main() -> None:
    sharedMem = mp.Array("b", TRACE_LENGTH * _ELEMENT_SIZE, lock=False)

    # Create and start processes
    plotProc = mp.Process(target=plotProcess, args=(sharedMem,))
    dataProc = mp.Process(target=dataProcess, args=(sharedMem,))

    plotProc.start()
    dataProc.start()

    try:
        while True:
            if not plotProc.is_alive() or not dataProc.is_alive():
                break
    except KeyboardInterrupt:
        pass

    # Terminate processes
    plotProc.terminate()
    dataProc.terminate()
    plotProc.join()
    dataProc.join()


if __name__ == "__main__":
    main()
