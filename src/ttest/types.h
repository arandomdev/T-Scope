#ifndef __TYPES_H__
#define __TYPES_H__

#include <ap_axi_sdata.h>
#include <ap_fixed.h>
#include <ap_int.h>
#include <cstdint>

namespace Hist {

#define FRAC_BITS 24 // Number of fractional bits to calculate with

// Predefined sizes
#define N_BINS 256  // number of bins per histogram
#define BIN_SIZE 32 // Number of bit in a bin

#define HIST_COUNT_SIZE 40 // (256 * 0xffffffff) fits within 40 bits
#define HIST_SUM_SIZE 47   // Max sum of all bins is 140187732508800

#define MEAN_INT_SIZE 8 // Max mean of 256

/// @brief Facilitates conversion between a double and integer
class DoubleIntConverter {
private:
  union Converter {
    double d;
    uint64_t i;
  };

public:
  static uint64_t toInt(double d) { return Converter{.d = d}.i; }
  static double toDouble(uint64_t i) { return Converter{.i = i}.d; }
};

/// @brief Generic stream packet with `last` signal
template <typename T> struct GenericPkt {
  T data;
  bool last;
};

/// @brief The input data type is 2 32-bit integers packed together
union InputData {
  struct {
    uint32_t a;
    uint32_t b;
  };
  uint64_t raw;
};

using InputPkt = ap_axiu<64, 0, 0, 0>;  // Input stream type
using OutputPkt = ap_axiu<64, 0, 0, 0>; // output 64 bit float

using Block = InputData[N_BINS / 2];    // Storage of whole histogram
using Count = ap_uint<HIST_COUNT_SIZE>; // The number of items
using CountInv = ap_ufixed<41, 1>;
using Sum = ap_uint<HIST_SUM_SIZE>; // The sum of all items

using Mean = ap_ufixed<8 + FRAC_BITS, 8>;          // Max mean of 255
using CenteredWeight = ap_fixed<8 + FRAC_BITS, 8>; // Max of 255
using CenteredWeightSquared = ap_ufixed<16 + FRAC_BITS, 16>;
using VarSum = ap_fixed<64, 55>;
using Var = ap_ufixed<15 + FRAC_BITS, 15>;

/// @brief Statistics on a histogram
struct Stats {
  Sum sum;
  Count count;
};

struct CountInvPair {
  CountInv countInv;
  CountInv adjCountInv;
};

using StatsPkt = GenericPkt<Stats>;
using CountInvPairPkt = GenericPkt<CountInvPair>;
using MeanPkt = GenericPkt<Mean>;
using VarSumPkt = GenericPkt<VarSum>;

} // namespace Hist

#endif // __TYPES_H__