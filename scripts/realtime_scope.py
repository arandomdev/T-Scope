import multiprocessing as mp
from typing import Any

import matplotlib.animation
import matplotlib.lines
import matplotlib.pyplot as plt
import numpy as np
import numpy.typing as npt
import pyTVLA

TraceLength = 8192  # Size of t-test trace
ElementType = np.float64  # T-test trace element type
DefaultLimitY = (-8, 8)  # Default Y axis shown

_ElementSize = ElementType().itemsize  # Size in bytes of the element type


class Scope(object):
    def __init__(self, axs: plt.Axes, data: npt.NDArray[ElementType]) -> None:
        self.axs = axs

        length = len(data)
        self.data = data

        xAxis = np.arange(0, length, 1)  # type: ignore
        self.line = matplotlib.lines.Line2D(xAxis, self.data)  # type: ignore
        self.axs.add_line(self.line)
        self.axs.set_xlim(0, length)
        self.axs.set_ylim(DefaultLimitY[0], DefaultLimitY[1])
        pass

    def update(self, _: Any) -> tuple[matplotlib.lines.Line2D]:
        self.line.set_ydata(self.data)
        return (self.line,)


def dataProcess(sharedMem: Any) -> None:
    data = np.frombuffer(sharedMem, dtype=ElementType)

    dataSourceA = pyTVLA.datasource.RandomDataSource(TraceLength, 8)
    dataSourceB = pyTVLA.datasource.RandomDataSource(TraceLength, 8)
    engine = pyTVLA.engine.SoftwareEngine(TraceLength)

    while True:
        engine.ingest(True, dataSourceA.next())
        engine.ingest(False, dataSourceB.next())
        data[:] = engine.calculate()
        pass


def plotProcess(sharedMem: Any) -> None:
    data = np.frombuffer(sharedMem, dtype=ElementType)

    fig, axs = plt.subplots()  # type: ignore
    scope = Scope(axs, data)

    _ = matplotlib.animation.FuncAnimation(fig, scope.update, interval=0, blit=False)
    plt.show()  # type: ignore


def main() -> None:
    sharedMem = mp.Array("b", TraceLength * _ElementSize, lock=False)

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
