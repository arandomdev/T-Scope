#include <histogram.hpp>
#include <stdexcept>

using namespace Histogram;

/// @brief Tests to see if the collector correctly adds traces
int main(int argc, char const *argv[]) {
  static const int traceLength = 4;

  Collector::BinT data[traceLength][256] = {0};
  auto c = Histogram::Collector(traceLength, &data);

  // Create 256 traces, all filled with a specific bin. i.e. {0, 0, 0, 0},
  // {1, 1, 1, 1}, and so on. This should result in the entire cache being
  // filled with 1s.
  std::vector<std::vector<uint8_t>> traces;
  for (size_t i = 0; i < Histogram::Collector::NumberOfBins; i++) {
    traces.emplace_back(traceLength, (uint8_t)i);
  }

  for (auto &t : traces) {
    c.addTrace8(&(*t.begin()), &(*t.end()));
  }

  // Check result
  for (auto &h : data) {
    for (auto &bin : h) {
      if (bin != 1) {
        throw std::logic_error("Collector incorrectly bins traces.");
      }
    }
  }

  /* code */
  return 0;
}
