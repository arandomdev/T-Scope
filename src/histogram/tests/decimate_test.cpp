#include <cassert>
#include <histogram.hpp>

using namespace Histogram;

/// @brief Tests to see if decimation works correctly.
int main(int argc, char const *argv[]) {
  Collector::BinT data[1][256] = {0};
  auto c = Collector(1, &data);

  uint8_t trace[] = {0};

  c.addTrace8(&trace[0], &trace[1]);
  c.addTrace8(&trace[0], &trace[1]);
  c.decimate();

  assert(data[0][0] == 1 && "Decimation failed: 2 should have become 1");
  for (unsigned int i = 1; i < 256; i++) {
    assert(data[0][i] == 0 && "Decimation failed, 0 should have become 0");
  }

  return 0;
}
