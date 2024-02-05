from enum import Enum
from typing import TypeVar

import numpy as np

DT = TypeVar("DT", bound=np.generic)  # Any generic numpy type
DT_HARDWARE = TypeVar("DT_HARDWARE", np.uint8, np.uint16)  # Hardware supported types


class TraceType(Enum):
    A = 0  # Trace of type A
    B = 1  # Trace of type B
