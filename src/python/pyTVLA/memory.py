import multiprocessing as mp
from abc import ABC
from dataclasses import dataclass
from types import TracebackType
from typing import Any, Generic, Type

import numpy as np
import numpy.typing as npt
import pyHistogram

from .types import (
    ArrayInterface,
    HardwareScalarType,
    MemoryType,
    ScalarType,
    T,
    TraceType,
)


class MemoryManager(ABC):
    traceLen: int

    @dataclass
    class _ArrayHolder(object):
        __array_interface__: ArrayInterface

        def asArray(self, dtype: Type[ScalarType]) -> npt.NDArray[ScalarType]:
            return np.array(self, copy=False)  # type: ignore

    def getArray(
        self, mType: MemoryType, dtype: Type[ScalarType]
    ) -> npt.NDArray[ScalarType]: ...

    def __enter__(self: T) -> T: ...

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None: ...


class SoftwareMemoryManager(MemoryManager):
    def __init__(self, traceLen: int) -> None:
        self.traceLen = traceLen

    def getArray(
        self, mType: MemoryType, dtype: Type[ScalarType]
    ) -> npt.NDArray[ScalarType]:
        return self._arrays[mType]

    def __enter__(self):
        # Create buffers
        self._buffers = {
            MemoryType.histA: mp.RawArray("b", self.traceLen * 256 * 4),
            MemoryType.histB: mp.RawArray("b", self.traceLen * 256 * 4),
            MemoryType.tvals: mp.RawArray("b", self.traceLen * 8),
        }

        self._arrays: dict[MemoryType, npt.NDArray[Any]] = {
            MemoryType.histA: np.frombuffer(  # type: ignore
                self._buffers[MemoryType.histA], dtype=np.uint32
            ),
            MemoryType.histB: np.frombuffer(  # type: ignore
                self._buffers[MemoryType.histB], dtype=np.uint32
            ),
            MemoryType.tvals: np.frombuffer(  # type: ignore
                self._buffers[MemoryType.tvals], dtype=np.float64
            ),
        }

        self._arrays[MemoryType.histA].shape = (self.traceLen, 256)  # type: ignore
        self._arrays[MemoryType.histB].shape = (self.traceLen, 256)  # type: ignore
        self._arrays[MemoryType.tvals].shape = (self.traceLen,)  # type: ignore

        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        pass


class TraditionalMemoryManager(MemoryManager):
    def __init__(self, traceLen: int, nTraces: int) -> None:
        """Traditional Memory Manager that holds set number of traces.

        Args:
            traceLen: The length of the trace.
            traces: The max number of traces allocate space for.
        """

        self.traceLen = traceLen
        self.nTraces = nTraces

    def getArray(
        self, mType: MemoryType, dtype: Type[ScalarType]
    ) -> npt.NDArray[ScalarType]:
        return self._arrays[mType]

    def __enter__(self):
        # Create buffers
        self._buffers = {
            MemoryType.tracesA: mp.RawArray("b", self.traceLen * self.nTraces * 2),
            MemoryType.tracesB: mp.RawArray("b", self.traceLen * self.nTraces * 2),
            MemoryType.tvals: mp.RawArray("b", self.traceLen * 8),
        }

        self._arrays: dict[MemoryType, npt.NDArray[Any]] = {
            MemoryType.tracesA: np.frombuffer(  # type: ignore
                self._buffers[MemoryType.tracesA], dtype=np.uint16
            ),
            MemoryType.tracesB: np.frombuffer(  # type: ignore
                self._buffers[MemoryType.tracesB], dtype=np.uint16
            ),
            MemoryType.tvals: np.frombuffer(  # type: ignore
                self._buffers[MemoryType.tvals], dtype=np.float64
            ),
        }

        self._arrays[MemoryType.tracesA].shape = (self.traceLen, self.nTraces)  # type: ignore
        self._arrays[MemoryType.tracesB].shape = (self.traceLen, self.nTraces)  # type: ignore
        self._arrays[MemoryType.tvals].shape = (self.traceLen,)  # type: ignore

        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        pass


class HistogramStorage(Generic[HardwareScalarType]):
    def __init__(
        self,
        memManager: MemoryManager,
        dtype: Type[HardwareScalarType],
    ) -> None:
        self._histA = pyHistogram.Collector(
            memManager.traceLen, memManager.getArray(MemoryType.histA, np.uint32)
        )
        self._histB = pyHistogram.Collector(
            memManager.traceLen, memManager.getArray(MemoryType.histB, np.uint32)
        )
        self._dtype = dtype

    def getHistograms(self) -> tuple[pyHistogram.Collector, pyHistogram.Collector]:
        return self._histA, self._histB

    def ingest(self, trace: npt.NDArray[HardwareScalarType], tType: TraceType) -> None:
        if self._dtype is np.uint8:
            if tType == TraceType.A:
                self._histA.addTrace8(trace)  # type: ignore
            elif tType == TraceType.B:
                self._histB.addTrace8(trace)  # type: ignore
            else:
                raise NotImplementedError
        elif self._dtype is np.uint16:
            if tType == TraceType.A:
                self._histA.addTrace10(trace)  # type: ignore
            elif tType == TraceType.B:
                self._histB.addTrace10(trace)  # type: ignore
            else:
                raise NotImplementedError
        else:
            raise NotImplementedError

    def decimate(self) -> None:
        self._histA.decimate()
        self._histB.decimate()


class TraditionalStorage(Generic[HardwareScalarType]):
    def __init__(
        self, memManager: TraditionalMemoryManager, dtype: Type[HardwareScalarType]
    ) -> None:
        self._tracesA = memManager.getArray(MemoryType.tracesA, np.uint16)
        self._tracesB = memManager.getArray(MemoryType.tracesB, np.uint16)

        self._dtype = dtype
        self._phaseA = 0
        self._phaseB = 0
        self._nTraces = memManager.nTraces

    def ingest(self, trace: npt.NDArray[HardwareScalarType], tType: TraceType) -> None:
        if self._dtype is np.uint8:
            raise NotImplementedError
        elif self._dtype is np.uint16:
            if tType == TraceType.A:
                self._tracesA[:, self._phaseA] = trace
                self._phaseA = (self._phaseA + 1) % self._nTraces
            elif tType == TraceType.B:
                self._tracesB[:, self._phaseB] = trace
                self._phaseB = (self._phaseB + 1) % self._nTraces
            else:
                raise NotImplementedError
        else:
            raise NotImplementedError

    def decimate(self) -> None:
        """No action."""
        pass
