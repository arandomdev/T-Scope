#!/usr/bin/env python3

import matplotlib.pyplot as plt
import numpy as np
from pyTVLA.datasource import ChipWhispererDataSource
from pyTVLA.scheduler import AESBiasedRoundsScheduler


def main() -> None:
    sch = AESBiasedRoundsScheduler(30)
    with ChipWhispererDataSource(8500, sch, np.uint16) as ds:
        trace = ds.next()[1]

        plt.plot(trace)  # type: ignore
        plt.title("Sample AES Power Trace")  # type: ignore
        plt.xlabel("Sample")  # type: ignore
        plt.ylabel("Power")  # type: ignore
        plt.show()  # type: ignore


if __name__ == "__main__":
    main()
