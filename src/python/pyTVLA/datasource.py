from abc import ABC
from types import TracebackType
from typing import Generic, Type

import chipwhisperer as cw
import numpy as np
import numpy.typing as npt

from .scheduler import Scheduler
from .types import DT, DT_HARDWARE, TraceType


class DataSource(ABC, Generic[DT]):
    def next(self) -> tuple[TraceType, npt.NDArray[DT]]:
        ...


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

        self.traceType = TraceType.A

    def next(self) -> tuple[TraceType, npt.NDArray[DT_HARDWARE]]:
        """Get the next random trace, same distribution for all trace types.

        Args:
            tType: The trace type
        """
        # Alternate trace type
        if self.traceType == TraceType.A:
            self.traceType = TraceType.B
        elif self.traceType == TraceType.B:
            self.traceType = TraceType.A
        else:
            raise NotImplementedError

        trace = self._rng.uniform(0, self._upperBound, self.traceLength).astype(  # type: ignore
            self.dtype
        )
        return self.traceType, trace


class ChipWhispererDataSource(Generic[DT_HARDWARE]):
    def __init__(
        self, traceLength: int, scheduler: Scheduler, dtype: type[DT_HARDWARE]
    ) -> None:
        """DataSource using a ChipWhisperer scope and target.
            Expects the target to already be programmed with a SimpleSerial compatible
        project.

        Args:
            traceLength: The length of traces.
            nCaptures: the number of captures that is planned.
            dtype: The numpy type of the captures. Only uint8 or uint16 are supported.
        """

        self._traceLength = traceLength
        self._scheduler = scheduler
        self._dtype = dtype

    def next(self) -> tuple[TraceType, npt.NDArray[DT_HARDWARE]]:
        tType, ktp = self._scheduler.next()
        trace = cw.capture_trace(
            self._scope,
            self._target,
            ktp.text,  # type: ignore
            ktp.key,  # type: ignore
            as_int=True,
        )

        if not trace:
            raise RuntimeError("Timeout when capture trace")
        return tType, trace.wave.astype(self._dtype)  # type: ignore

    def __enter__(self):
        # Create scope
        self._scope = cw.scope()  # type: ignore
        self._scope.default_setup(verbose=False)  # type: ignore
        self._scope.adc.samples = self._traceLength

        self._target = cw.target(self._scope)  # type: ignore
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ):
        self._scope.dis()
        self._target.dis()
