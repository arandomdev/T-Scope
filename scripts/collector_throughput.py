#!/usr/bin/env python3

import datetime

import numpy as np
import numpy.typing as npt
import pyHistogram

TRACE_LENGTH = 0x2000
ITERATIONS = 10000


def generateTrace8() -> npt.NDArray[np.uint8]:
    return np.random.default_rng().uniform(0, 0x100, TRACE_LENGTH).astype(np.uint8)


def generateTrace10() -> npt.NDArray[np.uint16]:
    return np.random.default_rng().uniform(0, 0x400, TRACE_LENGTH).astype(np.uint16)


def main() -> None:
    print("Performing test on histograms\n")

    collector = pyHistogram.Collector(TRACE_LENGTH)

    print("Generating traces\n")
    trace8 = generateTrace8()
    trace10 = generateTrace10()

    print("Running with 8bit traces...")
    start = datetime.datetime.now()
    for _ in range(ITERATIONS):
        collector.addTrace8(trace8)
    end = datetime.datetime.now()

    elapsed = (end - start).total_seconds()
    throughput = TRACE_LENGTH * 8 * ITERATIONS / 1e6 / elapsed  # Mbps
    print(f"elapsed={elapsed:.3f}s, throughput={throughput:.3f}Mbps\n")

    print("Running with 10bit traces...")
    start = datetime.datetime.now()
    for _ in range(ITERATIONS):
        collector.addTrace10(trace10)
    end = datetime.datetime.now()

    elapsed = (end - start).total_seconds()
    throughput = TRACE_LENGTH * 10 * ITERATIONS / 1e6 / elapsed  # Mbps
    print(f"elapsed={elapsed:.3f}s, throughput={throughput:.3f}Mbps")
    pass


if __name__ == "__main__":
    main()
