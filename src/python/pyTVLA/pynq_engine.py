import pathlib
import time
from types import TracebackType

import numpy as np

from .engine import Engine
from .types import T

try:
    import pynq

    _pynq_available = True
    overlay = pynq.Overlay(
        str(pathlib.Path(__file__).parent / "overlay" / "tTestCore.bit")
    )

except ImportError:
    _pynq_available = False


def _toFloat(x: int, e: int) -> float:
    c = abs(x)
    sign = 1
    if x < 0:
        # convert back from two's complement
        c = x - 1
        c = ~c
        sign = -1
    f = (1.0 * c) / (2**e)
    f = f * sign
    return f


class PynqEngine(Engine):
    def __init__(
        self,
        traceLen: int,
        histABuf: "pynq.buffer.PynqBuffer",
        histBBuf: "pynq.buffer.PynqBuffer",
        tvalsBuf: "pynq.buffer.PynqBuffer",
    ) -> None:
        if not _pynq_available:
            raise NotImplementedError

        self._traceLen = traceLen
        self._phase = 0

        self._histABuf = histABuf
        self._histBBuf = histBBuf
        self._tvalsBuf = tvalsBuf

        self._core = overlay.tTestCore  # type: ignore
        self._dmaHistA = overlay.dma0.sendchannel  # type: ignore
        self._dmaHistB = overlay.dma1.sendchannel  # type: ignore

    def calculate(self) -> tuple[int, int]:
        # Calculate offset
        offset = self._phase * 256 * 4

        self._core.write(0x0, 0x1)  # Start Core
        self._dmaHistA.transfer(self._histABuf, start=offset)
        self._dmaHistB.transfer(self._histBBuf, start=offset)

        while not self._core.register_map.CTRL.AP_DONE:
            time.sleep(0.001)

        self._tvalsBuf[self._phase] = _toFloat(self._coreOutput[0], 22)  # type: ignore

        r = (self._phase, self._phase + 1)
        self._phase = (self._phase + 1) % self._traceLen
        return r

    def __enter__(self: T) -> T:
        self._coreOutput = pynq.allocate(shape=(1,), dtype=np.uint32)  # type: ignore
        self._core.register_map.C = self._coreOutput.physical_address  # type: ignore
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        self._coreOutput.freebuffer()  # type: ignore
