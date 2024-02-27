#ifndef __TYPES_H__
#define __TYPES_H__

#include <ap_axi_sdata.h>
#include <ap_fixed.h>
#include <ap_int.h>

namespace Hist {

#define FRAC_BITS 24 // Number of fractional bits to calculate with

// Predefined sizes
#define N_BINS 256  // number of bins per histogram
#define BIN_SIZE 32 // Number of bit in a bin

#define HIST_COUNT_SIZE 40 // (256 * 0xffffffff) fits within 40 bits
#define HIST_SUM_SIZE 47   // Max sum of all bins is 140187732508800

#define MEAN_INT_SIZE 8 // Max mean of 256

union DoubleIntConverter {
  double d;
  uint64_t i;
};

using Block = ap_uint<32>[N_BINS];      // Storage of whole histogram
using Count = ap_uint<HIST_COUNT_SIZE>; // The number of items
using Sum = ap_uint<HIST_SUM_SIZE>;     // The sum of all items

using Mean = ap_ufixed<8 + FRAC_BITS, 8>;          // Max mean of 255
using CenteredWeight = ap_fixed<8 + FRAC_BITS, 8>; // Max of 255
using CenteredWeightSquared = ap_ufixed<16 + FRAC_BITS, 16>;
using VarSum = ap_fixed<64, 56>;
using Var = ap_ufixed<15 + FRAC_BITS, 15>;
using TvalDenom = ap_ufixed<8 + FRAC_BITS, 8>;
using Tval = ap_ufixed<8 + FRAC_BITS, 8>;

using BinPkt = ap_axiu<BIN_SIZE, 0, 0, 0>; // Input stream type
using OutPkt = ap_axiu<64, 0, 0, 0>;       // output 64 bit float

/// @brief Generic stream packet with `last` signal
template <typename _T> struct GenericPkt {
  using Type = _T;

  _T data;
  bool last;
};

using SumPkt = GenericPkt<Sum>;
using CountPkt = GenericPkt<Count>;
using MeanPkt = GenericPkt<Mean>;
using VarSumPkt = GenericPkt<VarSum>;
using VarPkt = GenericPkt<Var>;
using TvalPkt = GenericPkt<Tval>;

} // namespace Hist

#endif // __TYPES_H__