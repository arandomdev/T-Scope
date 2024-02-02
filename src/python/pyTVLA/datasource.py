from typing import Any

import numpy as np
import numpy.typing as npt


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
