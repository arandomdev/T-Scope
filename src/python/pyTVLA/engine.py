from typing import Any

import numpy as np
import numpy.typing as npt
import pyHistogram
import scipy.stats  # type: ignore

_TraceType = npt.NDArray[np.uint8] | npt.NDArray[np.uint16]


class TraditionalEngine(object):
    def __init__(self, traceLength: int) -> None:
        self.tracesA: list[_TraceType] = []
        self.tracesB: list[_TraceType] = []

    def ingest(self, traceType: bool, trace: _TraceType) -> None:
        if traceType:
            self.tracesA.append(trace)
        else:
            self.tracesB.append(trace)

    def calculate(self) -> npt.NDArray[np.floating[Any]]:
        with np.errstate(divide="ignore", invalid="ignore"):
            return scipy.stats.ttest_ind(self.tracesA, self.tracesB, equal_var=False)[0]  # type: ignore


class SoftwareEngine(object):
    """Software based engine. Uses the histogram library."""

    def __init__(self, traceLength: int) -> None:
        self._histA = pyHistogram.Collector(traceLength)
        self._histB = pyHistogram.Collector(traceLength)

        self._histBinWeights = np.arange(start=0, stop=0x100, step=1)  # type: ignore

        self.traceLength = traceLength

    def ingest(self, traceType: bool, trace: _TraceType) -> None:
        if traceType:
            if trace.dtype == np.uint8:
                self._histA.addTrace8(trace)  # type: ignore
            elif trace.dtype == np.uint16:
                self._histA.addTrace10(trace)  # type: ignore
            else:
                raise ValueError(f"Unknown trace data type: {trace.dtype}")
        else:
            if trace.dtype == np.uint8:
                self._histB.addTrace8(trace)  # type: ignore
            elif trace.dtype == np.uint16:
                self._histB.addTrace10(trace)  # type: ignore
            else:
                raise ValueError(f"Unknown trace data type: {trace.dtype}")

    def calculate(self) -> npt.NDArray[np.floating[Any]]:
        with np.errstate(divide="ignore", invalid="ignore"):
            histA = np.asarray(self._histA.getHistograms())
            histB = np.asarray(self._histB.getHistograms())

            # Get cardinalities
            cardA = histA.sum(axis=1)  # type: ignore
            cardB = histB.sum(axis=1)  # type: ignore

            # Get average of each histogram
            meanA = (histA * self._histBinWeights).sum(axis=1) / cardA  # type: ignore
            meanB = (histB * self._histBinWeights).sum(axis=1) / cardB  # type: ignore

            # Calculate variance
            centeredWeightsA = np.square(self._histBinWeights - np.vstack(meanA))
            centeredWeightsB = np.square(self._histBinWeights - np.vstack(meanB))
            varA = (histA * centeredWeightsA).sum(axis=1) / (cardA - 1)  # type: ignore
            varB = (histB * centeredWeightsB).sum(axis=1) / (cardB - 1)  # type: ignore

            # Calculate t-test
            t = (meanA - meanB) / np.sqrt((varA / cardA) + (varB / cardB))
            return t
