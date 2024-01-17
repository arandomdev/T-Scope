#include <array>
#include <limits>
#include <span>
#include <stdint.h>
#include <vector>

namespace Histogram {

/// @brief Collects traces and manages the histograms.
class Collector {
public:
  /// @brief The sample type in a trace
  using SampleT = uint8_t;
  /// @brief Type of the counter used for a histogram bin
  using BinT = uint32_t;

  static const int HistogramDepth = std::numeric_limits<SampleT>::digits;
  static const int NumberOfBins = 1 << HistogramDepth;

  using HistogramT = std::array<BinT, NumberOfBins>;
  using CacheT = std::vector<HistogramT>;

  /// @brief Initialize the collector.
  /// @param traceLength The length of the input traces.
  Collector(int traceLength);

  /// @brief Add a trace to the collector.
  /// @param trace The trace to add.
  /// @throws std::length_error when the trace is not the correct length.
  void addTrace(std::span<SampleT> trace);

  /// @brief Get the built histogram
  /// @return A 2D-array like stucture representing the histograms.
  const CacheT &getHistograms() const;

private:
  int traceLength;
  CacheT histograms;
};

} // namespace Histogram
