from abc import ABC
from typing import Generic, Type

import numpy as np
import numpy.typing as npt

from .types import DT, DT_HARDWARE, TraceType


class DataSource(ABC, Generic[DT]):
    def __init__(self, traceLength: int, dtype: Type[DT]) -> None:
        ...

    def next(self, tType: TraceType) -> npt.NDArray[DT]:
        ...


class RandomDataSource(DataSource[DT_HARDWARE]):
    def __init__(self, traceLength: int, dtype: Type[DT_HARDWARE]) -> None:
        """Uniform random data source.
        Args:
            traceLength: The trace length.
            dtype: The data type, only uint8 (8-bits) or uint16 (10-bits) is supported.
        """
        self._rng = np.random.default_rng()

        if dtype is np.uint8:
            self._upperBound = 1 << 8
        elif dtype is np.uint16:
            self._upperBound = 1 << 10
        else:
            raise TypeError

        self.traceLength = traceLength
        self.dtype = dtype

    def next(self, tType: TraceType) -> npt.NDArray[DT_HARDWARE]:
        """Get the next random trace, same distribution for all trace types.

        Args:
            tType: The trace type
        """
        return self._rng.uniform(0, self._upperBound, self.traceLength).astype(
            self.dtype
        )  # type: ignore
