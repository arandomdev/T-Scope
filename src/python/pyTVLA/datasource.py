from types import TracebackType
from typing import Generic, Type

import chipwhisperer as cw
import numpy as np
import numpy.typing as npt

from .types import DT_HARDWARE


class RandomDataSource(Generic[DT_HARDWARE]):
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

    def next(self) -> npt.NDArray[DT_HARDWARE]:
        """Get the next random trace, same distribution for all trace types.

        Args:
            tType: The trace type
        """
        return self._rng.uniform(0, self._upperBound, self.traceLength).astype(  # type: ignore
            self.dtype
        )


class ChipWhispererDataSource(Generic[DT_HARDWARE]):
    def __init__(self, traceLength: int, dtype: type[DT_HARDWARE]) -> None:
        """DataSource using a ChipWhisperer scope and target.
            Expects the target to already be programmed with a SimpleSerial compatible
        project.

        Args:
            traceLength: The length of traces.
            nCaptures: the number of captures that is planned.
            dtype: The numpy type of the captures. Only uint8 or uint16 are supported.
        """

        self.traceLength = traceLength

    def next(self, text: bytes, key: bytes) -> npt.NDArray[DT_HARDWARE]:
        trace = cw.capture_trace(self.scope, self.target, text, key, as_int=True)  # type: ignore
        if not trace:
            raise RuntimeError("Timeout when capture trace")
        return trace.wave  # type: ignore

    def __enter__(self):
        # Create scope
        self.scope = cw.scope()  # type: ignore
        self.scope.default_setup(verbose=False)  # type: ignore
        self.scope.adc.samples = self.traceLength

        self.target = cw.target(self.scope)  # type: ignore
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ):
        self.scope.dis()
        self.target.dis()
