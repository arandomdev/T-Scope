from typing import Generic, Type

import numpy as np
import numpy.typing as npt
import pyHistogram

from .types import DT_HARDWARE, TraceType


class HistogramStorage(Generic[DT_HARDWARE]):
    def __init__(
        self,
        traceLen: int,
        histMemA: npt.NDArray[np.uint32],
        histMemB: npt.NDArray[np.uint32],
        dtype: Type[DT_HARDWARE],
    ) -> None:
        self._histA = pyHistogram.Collector(traceLen, histMemA)
        self._histB = pyHistogram.Collector(traceLen, histMemB)
        self._dtype = dtype

    def getHistograms(self) -> tuple[pyHistogram.Collector, pyHistogram.Collector]:
        return self._histA, self._histB

    def ingest(self, trace: npt.NDArray[DT_HARDWARE], tType: TraceType):
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
