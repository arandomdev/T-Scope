#include <cassert>
#include <histogram.hpp>

using namespace Histogram;

/// @brief Tests to see if the collector scales correctly
int main(int argc, char const *argv[]) {
  Collector::BinT data[6][256] = {0};
  auto c = Collector(6, &data);

  uint16_t trace[] = {
      0,     // Index 0
      0x3FF, // 255
      0x200, // 128
      0x201, // 128
      0x202, // 129
      0x203  // 129
  };

  c.addTrace10(&trace[0], &trace[6]);
  assert(data[0][0] == 1 && "Fail min");
  assert(data[1][255] == 1 && "Fail max");
  assert(data[2][128] == 1 && "Fail round down at 0");
  assert(data[3][128] == 1 && "Fail round down at 1");
  assert(data[4][129] == 1 && "Fail round up at 2");
  assert(data[5][129] == 1 && "Fail round up at 3");
  return 0;
}
