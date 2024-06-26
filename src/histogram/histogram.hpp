#include <array>
#include <limits>
#include <stdint.h>
#include <vector>

namespace Histogram {

/// @brief Collects traces and manages the histograms.
class Collector {
public:
  /// @brief Type of the counter used for a histogram bin
  using BinT = uint32_t;

  static constexpr int HistogramDepth = std::numeric_limits<uint8_t>::digits;
  static constexpr int NumberOfBins = 1 << HistogramDepth;

  using HistogramT = BinT[NumberOfBins];
  using CacheT = HistogramT[];

  /// @brief Initialize the collector.
  /// @param traceLength The length of the input traces.
  Collector(unsigned int traceLength, CacheT *histograms);

  /// @brief Add a trace to the collector.
  /// @param begin Pointer to beginning of trace
  /// @param end Pointer to end of trace
  /// @throws std::length_error when the trace is not the correct length.
  void addTrace8(const uint8_t *begin, const uint8_t *end);

  /// @brief Add a 10-bit trace to the collector. Scales to 8 bit samples.
  /// @param begin Pointer to beginning of trace
  /// @param end Pointer to end of trace
  /// @throws std::length_error when the trace is not the correct length.
  void addTrace10(const uint16_t *begin, const uint16_t *end);

  /// @brief Divide all bin counts by 2.
  void decimate();

private:
  unsigned int traceLength;
  CacheT *histograms;
};

} // namespace Histogram
