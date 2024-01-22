#include <array>
#include <limits>
#include <span>
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

  using HistogramT = std::array<BinT, NumberOfBins>;
  using CacheT = std::vector<HistogramT>;

  /// @brief Initialize the collector.
  /// @param traceLength The length of the input traces.
  Collector(int traceLength);

  /// @brief Add a trace to the collector.
  /// @param trace The trace to add
  /// @throws std::length_error when the trace is not the correct length.
  void addTrace8(std::span<uint8_t> trace);

  /// @brief Add a 10-bit trace to the collector. Scales to 8 bit samples.
  /// @param trace The trace to add
  /// @throws std::length_error when the trace is not the correct length.
  void addTrace10(std::span<uint16_t> trace);

  /// @brief Get the built histogram
  /// @return A 2D-array like stucture representing the histograms.
  const CacheT &getHistograms() const;

private:
  int traceLength;
  CacheT histograms;
};

} // namespace Histogram
