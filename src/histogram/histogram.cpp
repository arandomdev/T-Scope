#include "histogram.hpp"

#include <stdexcept>

using namespace Histogram;

Collector::Collector(int traceLength)
    : traceLength(traceLength), histograms(traceLength) {}

void Histogram::Collector::addTrace8(std::span<uint8_t> trace) {
  if (trace.size() != traceLength) {
    throw std::length_error("Trace length is incorrect.");
  }

  for (size_t i = 0; i < trace.size(); i++) {
    // The sample is used as an index for the bins
    auto binI = trace[i];
    histograms[i][binI]++;
  }
}

void Histogram::Collector::addTrace10(std::span<uint16_t> trace) {
  if (trace.size() != traceLength) {
    throw std::length_error("Trace length is incorrect.");
  }

  for (size_t i = 0; i < trace.size(); i++) {
    // Scale while reducing truncation noise
    // https://stackoverflow.com/q/9645017/8746647
    uint16_t sample = trace[i];
    uint8_t binI = (sample & 0x3FC) == 0x3FC  // Check for overflow
                       ? 0xFF                 // Assign max
                       : (trace[i] + 2) >> 2; // Scale
    histograms[i][binI]++;
  }
}

const Collector::CacheT &Collector::getHistograms() const { return histograms; }
