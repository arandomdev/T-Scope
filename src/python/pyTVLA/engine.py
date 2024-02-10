from abc import ABC
from typing import Any, Generic, Type

import numpy as np
import numpy.typing as npt
import pyHistogram
import scipy.stats  # type: ignore

from .types import DT, DT_HARDWARE, TraceType


class Engine(ABC, Generic[DT]):
    def __init__(self, dtype: Type[DT]) -> None:
        ...

    def ingest(self, trace: npt.NDArray[DT], tType: TraceType) -> None:
        ...

    def calculate(self) -> npt.NDArray["np.floating[Any]"]:
        ...


class TraditionalEngine(Engine[DT]):
    def __init__(self, dtype: Type[DT]) -> None:
        self.tracesA: list[npt.NDArray[DT]] = []
        self.tracesB: list[npt.NDArray[DT]] = []

    def ingest(self, trace: npt.NDArray[DT], tType: TraceType) -> None:
        if tType == TraceType.A:
            self.tracesA.append(trace)
        elif tType == TraceType.B:
            self.tracesB.append(trace)
        else:
            raise NotImplementedError(f"Unknown trace type: {tType}")

    def calculate(self) -> npt.NDArray["np.floating[Any]"]:
        with np.errstate(divide="ignore", invalid="ignore"):
            return np.abs(
                scipy.stats.ttest_ind(self.tracesA, self.tracesB, equal_var=False)[0]  # type: ignore
            )


class SoftwareEngine(Engine[DT_HARDWARE]):
    """Software based engine. Uses the histogram library."""

    def __init__(self, traceLength: int, dtype: Type[DT_HARDWARE]) -> None:
        self._histA = pyHistogram.Collector(traceLength)
        self._histB = pyHistogram.Collector(traceLength)

        if dtype is np.uint8:
            self._ingestFuncA = self._histA.addTrace8
            self._ingestFuncB = self._histB.addTrace8
        elif dtype is np.uint16:
            self._ingestFuncA = self._histA.addTrace10
            self._ingestFuncB = self._histB.addTrace10
        else:
            raise ValueError("only uint8 or uint16 is supported.")

        self._histBinWeights = np.arange(start=0, stop=0x100, step=1)  # type: ignore

    def ingest(self, trace: npt.NDArray[DT_HARDWARE], tType: TraceType) -> None:
        if tType == TraceType.A:
            self._ingestFuncA(trace)  # type: ignore
        elif tType == TraceType.B:
            self._ingestFuncB(trace)  # type: ignore
        else:
            raise NotImplementedError(f"Unknown trace type: {tType}")

    def decimate(self) -> None:
        self._histA.decimate()
        self._histB.decimate()

    def calculate(self) -> npt.NDArray["np.floating[Any]"]:
        with np.errstate(divide="ignore", invalid="ignore"):
            histA = np.asarray(self._histA.getHistograms())  # type: ignore
            histB = np.asarray(self._histB.getHistograms())  # type: ignore

            # Get cardinalities
            cardA = histA.sum(axis=1)  # type: ignore
            cardB = histB.sum(axis=1)  # type: ignore

            # Get average of each histogram
            meanA = (histA * self._histBinWeights).sum(axis=1) / cardA  # type: ignore
            meanB = (histB * self._histBinWeights).sum(axis=1) / cardB  # type: ignore

            # Calculate variance
            centeredWeightsA = np.square(self._histBinWeights - np.vstack(meanA))  # type: ignore
            centeredWeightsB = np.square(self._histBinWeights - np.vstack(meanB))  # type: ignore
            varA = (histA * centeredWeightsA).sum(axis=1) / (cardA - 1)  # type: ignore
            varB = (histB * centeredWeightsB).sum(axis=1) / (cardB - 1)  # type: ignore

            # Calculate t-test
            t = np.abs((meanA - meanB) / np.sqrt((varA / cardA) + (varB / cardB)))  # type: ignore
            return t
