from abc import ABC
from dataclasses import dataclass

import numpy as np

from .types import TraceType


@dataclass
class KeyTextPair(object):
    key: bytes
    text: bytes


class Scheduler(ABC):
    def next(self) -> tuple[TraceType, KeyTextPair]:
        ...


class FixedRandomScheduler(Scheduler):
    def __init__(
        self, key: bytes, randTextLen: int, fixedTexts: tuple[bytes, ...]
    ) -> None:
        """Implements a alternating round robin fixed vs random schedule.

        For example,
        A (F0), B(Rand), A(F0), B(Rand), ...

        Args:
            key: The key to use.
            fixedTexts: The list of fixed plain texts to choose from.
        """

        self._key = key
        self._randTextLen = randTextLen
        self._fixedTexts = fixedTexts

        self._phase = 0  # Index into fixed texts
        self._rand = False  # If the next pair should be random

        self._rng = np.random.default_rng()

    def next(self) -> tuple[TraceType, KeyTextPair]:
        key = self._key

        if self._rand:
            tType = TraceType.A
            text = self._rng.bytes(self._randTextLen)
            self._rand = False
        else:
            tType = TraceType.B
            text = self._fixedTexts[self._phase]
            self._rand = True
            self._phase = (self._phase + 1) % len(self._fixedTexts)

        return tType, KeyTextPair(key, text)
