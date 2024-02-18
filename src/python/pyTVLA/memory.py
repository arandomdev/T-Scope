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

    def __init__(self, traceLen: int) -> None:
        ...

    def getArray(
        self, mType: MemoryType, dtype: Type[ScalarType]
    ) -> npt.NDArray[ScalarType]:
        ...

    def __enter__(self: T) -> T:
        ...

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        ...


class SoftwareMemoryManager(MemoryManager):
    def __init__(self, traceLen: int) -> None:
        self.traceLen = traceLen

        # Create buffers
        self._buffers = {
            MemoryType.histA: mp.RawArray("b", traceLen * 256 * 4),
            MemoryType.histB: mp.RawArray("b", traceLen * 256 * 4),
            MemoryType.tvals: mp.RawArray("b", traceLen * 8),
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

        self._arrays[MemoryType.histA].shape = (traceLen, 256)  # type: ignore
        self._arrays[MemoryType.histB].shape = (traceLen, 256)  # type: ignore
        self._arrays[MemoryType.tvals].shape = (traceLen,)  # type: ignore

    def getArray(
        self, mType: MemoryType, dtype: Type[ScalarType]
    ) -> npt.NDArray[ScalarType]:
        return self._arrays[mType]

    def __enter__(self):
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

    def ingest(self, trace: npt.NDArray[HardwareScalarType], tType: TraceType):
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

    def decimate(self):
        self._histA.decimate()
        self._histB.decimate()
