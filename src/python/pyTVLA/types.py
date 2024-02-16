from enum import Enum
from typing import Any, TypeVar

import numpy as np

T = TypeVar("T")
ScalarType = TypeVar("ScalarType", bound=np.generic)
HardwareScalarType = TypeVar("HardwareScalarType", np.uint8, np.uint16)
ArrayInterface = dict[str, Any]


class TraceType(Enum):
    A = 0  # Trace of type A
    B = 1  # Trace of type B


class MemoryType(Enum):
    histA = 0
    histB = 1
    tvals = 2
    temp = 3
