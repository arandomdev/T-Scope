import pathlib
import time
import warnings
from types import TracebackType
from typing import Type

import numpy as np

from .engine import Engine, SoftwareEngine
from .memory import MemoryManager, SoftwareMemoryManager
from .types import MemoryType, ScalarType

try:
    import pynq

    overlay = pynq.Overlay(
        str(pathlib.Path(__file__).parent / "overlay" / "tTestCore.bit")
    )

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

    class PynqMemoryManager(MemoryManager):  # type: ignore
        def __init__(self, traceLen: int) -> None:
            self.traceLen = traceLen

        def getArray(
            self, mType: MemoryType, dtype: Type[ScalarType]
        ) -> "pynq.buffer.PynqBuffer":
            return self._arrays[mType]

        def __enter__(self):
            self._arrays: dict[MemoryType, "pynq.buffer.PynqBuffer"] = {
                MemoryType.histA: pynq.allocate(  # type: ignore
                    shape=(self.traceLen, 256),
                    dtype=np.uint32,  # type: ignore
                ),
                MemoryType.histB: pynq.allocate(  # type: ignore
                    shape=(self.traceLen, 256),
                    dtype=np.uint32,  # type: ignore
                ),
                MemoryType.tvals: pynq.allocate(  # type: ignore
                    shape=(self.traceLen,),
                    dtype=np.float64,  # type: ignore
                ),
                MemoryType.temp: pynq.allocate(  # type: ignore
                    shape=(1,),
                    dtype=np.uint32,  # type: ignore
                ),
            }

            return self

        def __exit__(
            self,
            exc_type: type[BaseException] | None,
            exc_val: BaseException | None,
            exc_tb: TracebackType | None,
        ) -> None:
            for a in self._arrays.values():
                a.freebuffer()

    class PynqEngine(Engine):  # type: ignore
        def __init__(self, memManager: PynqMemoryManager) -> None:
            self._traceLen = memManager.traceLen
            self._phase = 0

            self._histA = memManager.getArray(MemoryType.histA, dtype=np.uint32)
            self._histB = memManager.getArray(MemoryType.histB, dtype=np.uint32)
            self._tvals = memManager.getArray(MemoryType.tvals, dtype=np.float64)
            self._coreOutput = memManager.getArray(MemoryType.temp, dtype=np.uint32)

            self._core = overlay.tTestCore  # type: ignore
            self._core.register_map.C = self._coreOutput.physical_address  # type: ignore
            self._dmaHistA = overlay.dma0.sendchannel  # type: ignore
            self._dmaHistB = overlay.dma1.sendchannel  # type: ignore

        def calculate(self) -> tuple[int, int]:
            # Calculate offset
            offset = self._phase * 256 * 4

            self._core.write(0x0, 0x1)
            self._dmaHistA.transfer(self._histA, start=offset)
            self._dmaHistB.transfer(self._histB, start=offset)

            while not self._core.register_map.CTRL.AP_DONE:
                time.sleep(0.001)

            self._tvals[self._phase] = _toFloat(self._coreOutput[0], 22)

            r = (self._phase, self._phase + 1)
            self._phase = (self._phase + 1) % self._traceLen
            return r


except ImportError:

    class PynqMemoryManager(SoftwareMemoryManager):
        def __init__(self, traceLen: int) -> None:
            warnings.warn(
                "PynqMemoryManager is not available, using SoftwareMemoryManager instead."
            )
            super().__init__(traceLen)

    class PynqEngine(SoftwareEngine):
        def __init__(self, memManager: SoftwareMemoryManager) -> None:
            warnings.warn("PynqEngine is not available, using SoftwareEngine instead.")
            super().__init__(memManager)
