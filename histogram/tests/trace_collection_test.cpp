#include <histogram.hpp>
#include <stdexcept>

/// @brief Tests to see if the collector correctly adds traces
int main(int argc, char const *argv[]) {
  using SampleT = Histogram::Collector::SampleT;
  static const int traceLength = 4;

  auto c = Histogram::Collector(traceLength);

  // Create 256 traces, all filled with a specific bin. i.e. {0, 0, 0, 0},
  // {1, 1, 1, 1}, and so on. This should result in the entire cache being
  // filled with 1s.
  std::vector<std::vector<Histogram::Collector::SampleT>> traces;
  for (size_t i = 0; i < Histogram::Collector::NumberOfBins; i++) {
    traces.emplace_back(traceLength, i);
  }

  for (auto &t : traces) {
    c.addTrace(t);
  }

  // Check result
  auto histograms = c.getHistograms();
  for (auto &h : histograms) {
    for (auto &bin : h) {
      if (bin != 1) {
        throw std::logic_error("Collector incorrectly bins traces.");
      }
    }
  }

  /* code */
  return 0;
}
