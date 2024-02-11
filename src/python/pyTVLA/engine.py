from abc import ABC

import numpy as np
import numpy.typing as npt


class Engine(ABC):
    def calculate(self) -> tuple[int, int]:
        """Calculate the next range of t-values.

        Returns:
            A continuous index range of the t-values updated."""
        ...


class SoftwareEngine(Engine):
    def __init__(
        self,
        histA: npt.NDArray[np.uint32],
        histB: npt.NDArray[np.uint32],
        tVals: npt.NDArray[np.float64],
    ) -> None:
        self._histA = histA
        self._histB = histB
        self._tVals = tVals

        self._histBinWeights = np.arange(start=0, stop=256, step=1)  # type: ignore

    def calculate(self) -> tuple[int, int]:
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
            self._tVals[:] = t
            return 0, len(t)
