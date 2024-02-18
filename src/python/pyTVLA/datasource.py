from abc import ABC
from types import TracebackType
from typing import Generic, Type

import chipwhisperer as cw
import numpy as np
import numpy.typing as npt

from .scheduler import Scheduler
from .types import HardwareScalarType, ScalarType, T, TraceType


class DataSource(ABC, Generic[ScalarType]):
    def next(self) -> tuple[TraceType, npt.NDArray[ScalarType]]:
        ...

    def __enter__(self: T) -> T:
        ...

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        ...


class RandomDataSource(Generic[HardwareScalarType]):
    def __init__(self, traceLength: int, dtype: Type[HardwareScalarType]) -> None:
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

    def next(self) -> tuple[TraceType, npt.NDArray[HardwareScalarType]]:
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

    def __enter__(self):
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ) -> None:
        pass


class ChipWhispererDataSource(Generic[HardwareScalarType]):
    def __init__(
        self, traceLength: int, scheduler: Scheduler, dtype: type[HardwareScalarType]
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

    def next(self) -> tuple[TraceType, npt.NDArray[HardwareScalarType]]:
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

        self._scope.clock.adc_src = "clkgen_x1"  # type: ignore
        self._scope.adc.decimate = 2
        self._scope.clock.clkgen_freq = 32000000  # type: ignore
        self._target.baud = 166400  # type: ignore
        self._scope.try_wait_clkgen_locked(10)  # type: ignore

        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_val: BaseException | None,
        exc_tb: TracebackType | None,
    ):
        self._scope.dis()
        self._target.dis()
