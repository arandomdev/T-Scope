#include <histogram.hpp>
#include <stdexcept>

/// @brief Tests to see if the collector catches incorrect length traces.
int main(int argc, char const *argv[]) {
  auto c = Histogram::Collector(4);

  uint8_t correctLen[] = {1, 1, 1, 1};
  uint8_t incorrectLen[] = {1, 1, 1, 1, 1};

  // This should not throw
  c.addTrace8(&correctLen[0], &correctLen[4]);

  try {
    // This should throw
    c.addTrace8(&incorrectLen[0], &incorrectLen[5]);
  } catch (const std::length_error &) {
  }

  return 0;
}
