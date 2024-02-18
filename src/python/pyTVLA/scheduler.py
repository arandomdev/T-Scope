from abc import ABC
from dataclasses import dataclass

import numpy as np

from .aes import AES
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
        A (Rand), B(F0), A(Rand), B(F1), ...

        Args:
            key: The key to use.
            fixedTexts: The list of fixed plain texts to choose from.
        """

        self._key = key
        self._randTextLen = randTextLen
        self._fixedTexts = fixedTexts

        self._currentIndex = 0  # Index into fixed texts
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
            text = self._fixedTexts[self._currentIndex]
            self._rand = True
            self._currentIndex = (self._currentIndex + 1) % len(self._fixedTexts)

        return tType, KeyTextPair(key, text)


class AESBiasedRoundsScheduler(Scheduler):
    def __init__(self, textsPerRound: int, key: bytes | None = None) -> None:
        """Implements a rotating bias round scheduler.

        The scheduler alternates between random and bias cipher texts.
        For each biased round it generates a set number of plain texts before switching
        to the next round.

        A(Rand), B(B0_0), A(Rand), B(B0_1) ...
        A(Rand), B(B1_0), A(Rand), B(B1_1) ...
        ...

        Args:
            key: The key to use.
            textsPerRound: The number of texts to generate per biased round.
        """
        self._rng = np.random.default_rng()

        if key is None:
            self._key = self._rng.bytes(16)
        else:
            if len(key) != 16:
                raise ValueError("Key must be 16 bytes")
            self._key = key

        self._textsPerRound = textsPerRound
        self._cipher = AES(self._key)

        self._rand = False  # If the next round should be a random text
        self._currentRound = 0
        self._roundCount = 0  # Number text generated for the current round

    def next(self) -> tuple[TraceType, KeyTextPair]:
        # Get random bytes for the plain/cipher text
        text = bytearray(self._rng.bytes(16))

        if self._rand:
            tType = TraceType.A
            plainText = text
            self._rand = False
        else:
            tType = TraceType.B

            # Choose byte indices to keep random
            keep = self._rng.integers(low=0, high=16, size=2)  # type: ignore
            for i in range(16):
                if i not in keep:
                    text[i] = 0x0

            # Decrypt
            plainText = self._cipher.decrypt_lastnrounds_block(self._currentRound, text)  # type: ignore

            # Update indices
            self._rand = True

            self._roundCount = (self._roundCount + 1) % self._textsPerRound
            if self._roundCount == 0:
                self._currentRound = (self._currentRound + 1) % 10

        return tType, KeyTextPair(self._key, bytes(plainText))
