#!/usr/bin/env python3

import numpy as np
import pyTVLA

def main() -> None:
    # create some data
    tE = pyTVLA.engine.TraditionalEngine(3000)
    sE = pyTVLA.engine.SoftwareEngine(3000)

    dataA = np.random.randint(low=0, high=256, size=(2, 3000), dtype=np.uint8)
    dataB = np.random.randint(low=0, high=256, size=(2, 3000), dtype=np.uint8)

    for t in dataA:
        tE.ingest(True, t)
        sE.ingest(True, t)
    for t in dataB:
        tE.ingest(False, t)
        sE.ingest(False, t)

    data = sE.calculate()
    print(data)
    pass


if __name__ == "__main__":
    main()
