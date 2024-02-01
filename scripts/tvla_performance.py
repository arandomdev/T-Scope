from typing import Any

import numpy as np
import numpy.typing as npt
import pyHistogram


class RandomDataSource(object):
    def __init__(self, traceLength: int, nBits: int) -> None:
        """Uniform random data source.
        Args:
            traceLength: The trace length.
            dataType: The data type, 8 for 8 bits, 10 for 10 bits
        """
        self._rng = np.random.default_rng()

        if nBits == 8:
            self._upperBound = 0x100
            self._dType = np.uint8
        elif nBits == 10:
            self._upperBound = 0x100
            self._dType = np.uint16
        else:
            raise ValueError(f"Unsupported number of bits: {nBits}")

        self.traceLength = traceLength

    def next(self) -> npt.NDArray[np.integer[Any]]:
        return self._rng.uniform(0, self._upperBound, self.traceLength).astype(
            self._dType
        )


class SoftwareEngine(object):
    """Software based engine. Uses the histogram library."""

    def __init__(self, traceLength: int) -> None:
        self._histA = pyHistogram.Collector(traceLength)
        self._histB = pyHistogram.Collector(traceLength)

        self._histBinWeights = np.arange(start=0, stop=0x100, step=1)  # type: ignore

        self.traceLength = traceLength

    def ingest(self, traceType: bool, trace: npt.NDArray[np.integer[Any]]) -> None:
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

    def calculate(self) -> npt.NDArray[np.integer[Any]]:
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


def main() -> None:
    # create some data
    pass


if __name__ == "__main__":
    main()
