#include <cassert>
#include <histogram.hpp>

/// @brief Tests to see if the collector scales correctly
int main(int argc, char const *argv[]) {
  auto c = Histogram::Collector(6);

  std::vector<uint16_t> correctLen{
      0,     // Index 0
      0x3FF, // 255
      0x200, // 128
      0x201, // 128
      0x202, // 129
      0x203  // 129
  };

  c.addTrace10(correctLen);
  auto h = c.getHistograms();
  assert(h[0][0] == 1 && "Fail min");
  assert(h[1][255] == 1 && "Fail max");
  assert(h[2][128] == 1 && "Fail round down at 0");
  assert(h[3][128] == 1 && "Fail round down at 1");
  assert(h[4][129] == 1 && "Fail round up at 2");
  assert(h[5][129] == 1 && "Fail round up at 3");
  return 0;
}
