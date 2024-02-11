#include "histogram.hpp"

#include <stdexcept>

using namespace Histogram;

Collector::Collector(unsigned int traceLength, CacheT *histograms)
    : traceLength(traceLength), histograms(histograms) {}

void Collector::addTrace8(const uint8_t *begin, const uint8_t *end) {
  if (end - begin != traceLength) {
    throw std::length_error("Trace length is incorrect.");
  }

  for (size_t i = 0; i < traceLength; i++) {
    // The sample is used as an index for the bins
    auto binI = begin[i];
    (*histograms)[i][binI]++;
  }
}

void Collector::addTrace10(const uint16_t *begin, const uint16_t *end) {
  if (end - begin != traceLength) {
    throw std::length_error("Trace length is incorrect.");
  }

  for (size_t i = 0; i < traceLength; i++) {
    // Scale while reducing truncation noise
    // https://stackoverflow.com/q/9645017/8746647
    uint16_t sample = begin[i];
    uint8_t binI = (sample & 0x3FC) == 0x3FC  // Check for overflow
                       ? 0xFF                 // Assign max
                       : (begin[i] + 2) >> 2; // Scale
    (*histograms)[i][binI]++;
  }
}

void Collector::decimate() {
  for (size_t i = 0; i < traceLength; i++) {
    for (size_t j = 0; j < NumberOfBins; j++) {
      (*histograms)[i][j] >>= 1;
    }
  }
}
