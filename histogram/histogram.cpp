#include "histogram.hpp"

#include <stdexcept>

using namespace Histogram;

Collector::Collector(int traceLength)
    : traceLength(traceLength), histograms(traceLength) {}

void Histogram::Collector::addTrace(std::span<SampleT> trace) {
  if (trace.size() != traceLength) {
    throw std::length_error("Trace length is incorrect.");
  }

  for (size_t i = 0; i < trace.size(); i++) {
    // The sample is used as an index for the bins
    auto binI = trace[i];
    histograms[i][binI]++;
  }
}

const Collector::CacheT &Collector::getHistograms() const { return histograms; }
