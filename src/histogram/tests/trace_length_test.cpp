#include <histogram.hpp>
#include <stdexcept>

/// @brief Tests to see if the collector catches incorrect length traces.
int main(int argc, char const *argv[]) {
  auto c = Histogram::Collector(4);

  std::vector<uint8_t> correctLen{1, 1, 1, 1};
  std::vector<uint8_t> incorrectLen{1, 1, 1, 1, 1};

  // This should not throw
  c.addTrace8(correctLen);

  try {
    // This should throw
    c.addTrace8(incorrectLen);
  } catch (const std::length_error &) {
  }

  return 0;
}
