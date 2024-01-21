#include <histogram.hpp>
#include <stdexcept>

/// @brief Tests to see if the collector catches incorrect length traces.
int main(int argc, char const *argv[]) {
  using SampleT = Histogram::Collector::SampleT;

  auto c = Histogram::Collector(4);

  std::vector<SampleT> correctLen{1, 1, 1, 1};
  std::vector<SampleT> incorrectLen{1, 1, 1, 1, 1};

  // This should not throw
  c.addTrace(correctLen);

  try {
    // This should throw
    c.addTrace(incorrectLen);
  } catch (const std::length_error &) {
  }

  return 0;
}
