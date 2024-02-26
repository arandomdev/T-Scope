from abc import ABC

import numpy as np

from .memory import SoftwareMemoryManager
from .types import MemoryType


class Engine(ABC):
    def calculate(self) -> None:
        """Calculate the next trace of t-values."""
        ...


class SoftwareEngine(Engine):
    def __init__(self, memManager: SoftwareMemoryManager) -> None:
        self._histA = memManager.getArray(MemoryType.histA, np.uint32)
        self._histB = memManager.getArray(MemoryType.histB, np.uint32)
        self._tvals = memManager.getArray(MemoryType.tvals, np.float64)
        self._histBinWeights = np.arange(start=0, stop=256, step=1)  # type: ignore

    def calculate(self) -> None:
        with np.errstate(divide="ignore", invalid="ignore"):
            histA = np.copy(self._histA)  # type: ignore
            histB = np.copy(self._histB)  # type: ignore

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
            self._tvals[:] = t  # type: ignore
