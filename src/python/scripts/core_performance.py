#!/usr/bin/env python3

import time
from dataclasses import dataclass
from typing import Any, Literal

import click
import numpy as np
from pyTVLA.datasource import ChipWhispererDataSource, RandomDataSource
from pyTVLA.engine import SoftwareEngine
from pyTVLA.memory import HistogramStorage, MemoryManager, SoftwareMemoryManager
from pyTVLA.pynq import PynqEngine, PynqMemoryManager
from pyTVLA.scheduler import AESBiasedRoundsScheduler
from pyTVLA.types import MemoryType


@dataclass
class SharedState(object):
    memoryManager: MemoryManager


@dataclass
class ProgramArguments(object):
    traceLength: int
    trials: int
    numTraces: int

    @classmethod
    def fromDict(cls, options: dict[str, Any]):
        return cls(
            traceLength=options["trace_length"],
            trials=options["trials"],
            numTraces=options["num_traces"],
        )


@click.command(name="core_performance")
@click.option(
    "--trace-length", help="How many samples per trace.", type=int, default=2000 #8500
)
@click.option(
    "--trials",
    help="The number of times the t-test engines are run, times are averaged.",
    type=int,
    default=30,
)
@click.option(
    "--num-traces",
    help="Number of traces measured and stored in the histograms.",
    type=int,
    default=50,
)
def main(**kwargs: dict[str, Any]) -> None:
    args = ProgramArguments.fromDict(kwargs)

    # sch = AESBiasedRoundsScheduler(30)
    # dsInst = ChipWhispererDataSource(args.traceLength, sch, np.uint16)
    dsInst = RandomDataSource(args.traceLength, np.uint16)
    
    with SoftwareMemoryManager(args.traceLength) as sMemManager, PynqMemoryManager(args.traceLength) as pMemManager, dsInst as ds:
        sStore = HistogramStorage(sMemManager, np.uint16)
        pStore = HistogramStorage(pMemManager, np.uint16)

        for ii in range(args.numTraces):
            tType, trace = ds.next()
            sStore.ingest(trace, tType)
            pStore.ingest(trace, tType)

        stotal = 0
        sEngine = SoftwareEngine(sMemManager)
        for ii in range(args.trials):
            t0 = time.time()
            sEngine.calculate()
            t1 = time.time()
            stotal += t1-t0

        ptotal = 0
        pEngine = PynqEngine(pMemManager)
        for ii in range(args.trials):
            t0 = time.time()
            pEngine.calculate()
            t1 = time.time()
            ptotal += t1-t0
        
        bits = 2 * 32 * 256 * args.traceLength * args.trials
        print("Software Average Time(s): " + str(stotal / args.trials))
        print("Hardware Average Time(s): " + str(ptotal / args.trials))
        print(str(stotal/ptotal) + " times faster")
        print("Software Throughput(bits/s): " + str(bits / stotal))
        print("Hardware Throughput(bits/s): " + str(bits / ptotal))

    
if __name__ == "__main__":
    main()
