#include "tTest.h"
#include <assert.h>
#include <hls_math.h>
#include <hls_stream.h>
#include <hls_streamofblocks.h>

void sumHist(hls::stream<Hist::InputPkt> &histStream,
             hls::stream_of_blocks<Hist::Block, 4> &histBlockStream,
             hls::stream<Hist::StatsPkt> &statsStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    hls::write_lock<Hist::Block> histBlockLock(histBlockStream);
    Hist::Stats stats{.sum = 0, .count = 0};

  SumLoop:
    for (int i = 0; i < N_BINS; i += 2) {
      auto inputPkt = histStream.read();
      Hist::InputData data{.raw = inputPkt.data};

      histBlockLock[i / 2] = data;

      stats.sum += (data.a * i) + (data.b * (i + 1));
      stats.count += data.a + data.b;

      eos = inputPkt.last;
    }

    statsStream.write({.data = stats, .last = eos});
  }
}

void calcMeanAndInv(hls::stream<Hist::StatsPkt> &statsStream,
                    hls::stream<Hist::MeanPkt> &meanStream,
                    hls::stream<Hist::CountInvPairPkt> &countInvPairStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    auto statsPkt = statsStream.read();
    auto sum = statsPkt.data.sum;
    auto count = statsPkt.data.count;

    auto countInv = count ? (Hist::CountInv)(1) / count : (Hist::CountInv)(0);
    auto adjCountInv = (count > 1)
                           ? (Hist::CountInv)(1) / (Hist::Count)(count - 1)
                           : (Hist::CountInv)(0);

    Hist::Mean mean = sum * countInv;

    bool last = statsPkt.last;
    meanStream.write({.data = mean, .last = last});
    countInvPairStream.write(
        {.data = {.countInv = countInv, .adjCountInv = adjCountInv},
         .last = last});
    eos = last;
  }
}

template <typename T>
void duplicateStream(hls::stream<T> &input, hls::stream<T> &a,
                     hls::stream<T> &b) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    T pkt = input.read();
    eos = pkt.last;
    a.write(pkt);
    b.write(pkt);
  }
}

void calcVarSum(hls::stream_of_blocks<Hist::Block, 4> &histBlockStream,
                hls::stream<Hist::MeanPkt> &meanStream,
                hls::stream<Hist::VarSumPkt> &varSumStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    hls::read_lock<Hist::Block> histBlockLock(histBlockStream);
    auto meanPkt = meanStream.read();
    Hist::VarSum sum = 0;

  SumLoop:
    for (int i = 0; i < N_BINS; i += 2) {
      Hist::CenteredWeight centeredWeight1 = i - meanPkt.data;
      Hist::CenteredWeightSquared centeredWeightSquared1 =
          centeredWeight1 * centeredWeight1;

      Hist::CenteredWeight centeredWeight2 = (i + 1) - meanPkt.data;
      Hist::CenteredWeightSquared centeredWeightSquared2 =
          centeredWeight2 * centeredWeight2;

      auto data = histBlockLock[i / 2];
      sum += centeredWeightSquared1 * data.a;
      sum += centeredWeightSquared2 * data.b;
    }

    eos = meanPkt.last;
    varSumStream.write({sum, meanPkt.last});
  }
}

void calcTval(hls::stream<Hist::MeanPkt> &meanAStream,
              hls::stream<Hist::MeanPkt> &meanBStream,
              hls::stream<Hist::VarSumPkt> &varSumAStream,
              hls::stream<Hist::VarSumPkt> &varSumBStream,
              hls::stream<Hist::CountInvPairPkt> &countInvPairAStream,
              hls::stream<Hist::CountInvPairPkt> &countInvPairBStream,
              hls::stream<Hist::OutputPkt> &outputStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    auto meanAPkt = meanAStream.read();
    auto meanBPkt = meanBStream.read();
    auto varSumAPkt = varSumAStream.read();
    auto varSumBPkt = varSumBStream.read();
    auto countInvPairAPkt = countInvPairAStream.read();
    auto countInvPairBPkt = countInvPairBStream.read();

    auto countInvA = countInvPairAPkt.data.countInv;
    auto countInvB = countInvPairBPkt.data.countInv;
    auto adjCountInvA = countInvPairAPkt.data.adjCountInv;
    auto adjCountInvB = countInvPairBPkt.data.adjCountInv;

    // subtract mean
    Hist::Mean diff = (meanAPkt.data > meanBPkt.data)
                          ? (Hist::Mean)(meanAPkt.data - meanBPkt.data)
                          : (Hist::Mean)(meanBPkt.data - meanAPkt.data);

    // get variance
    Hist::Var varA = varSumAPkt.data * adjCountInvA;
    Hist::Var varB = varSumBPkt.data * adjCountInvB;

    // divide by count
    Hist::Var divA = varA * countInvA;
    Hist::Var divB = varB * countInvB;

    // Add
    Hist::Var divSum = divA + divB;

    // Sqrt
    float denom = sqrtf(divSum.to_float());
    float denomInv = denom ? 1 / denom : 0;

    // divide
    float tval = (float)diff * denomInv;

    // Output
    bool last = meanAPkt.last;
    assert((last == meanBPkt.last) && (last == varSumAPkt.last) &&
           (last == varSumBPkt.last) && (last == countInvPairAPkt.last) &&
           (last == countInvPairBPkt.last));

    Hist::OutputPkt outputPkt;
    outputPkt.data = Hist::DoubleIntConverter::toInt(tval);
    outputPkt.keep = -1;
    outputPkt.last = last;
    outputStream.write(outputPkt);
    eos = last;
  }
}

/// @brief Top function for core
void tTest(hls::stream<Hist::InputPkt> &histAStream,
           hls::stream<Hist::InputPkt> &histBStream,
           hls::stream<Hist::OutputPkt> &outputStream) {
#pragma HLS INTERFACE mode = axis port = histAStream, histBStream, outputStream
#pragma HLS INTERFACE mode = s_axilite port = return

#pragma HLS DATAFLOW
  // Define streams
  hls::stream_of_blocks<Hist::Block, 4> histABlockStream;
  hls::stream_of_blocks<Hist::Block, 4> histBBlockStream;
#pragma HLS BIND_STORAGE variable = histABlockStream type = RAM_2P impl = bram
#pragma HLS BIND_STORAGE variable = histBBlockStream type = RAM_2P impl = bram

  hls::stream<Hist::StatsPkt> statsAStream;
  hls::stream<Hist::StatsPkt> statsBStream;

  hls::stream<Hist::CountInvPairPkt> countInvPairAStream;
  hls::stream<Hist::CountInvPairPkt> countInvPairBStream;
#pragma HLS stream variable = countInvPairAStream depth = 4
#pragma HLS stream variable = countInvPairBStream depth = 4

  hls::stream<Hist::MeanPkt> meanAStream;
  hls::stream<Hist::MeanPkt> meanBStream;
  hls::stream<Hist::MeanPkt> meanAStreamDup0;
  hls::stream<Hist::MeanPkt> meanBStreamDup0;
  hls::stream<Hist::MeanPkt> meanAStreamDup1;
  hls::stream<Hist::MeanPkt> meanBStreamDup1;
#pragma HLS stream variable = meanAStreamDup0 depth = 3
#pragma HLS stream variable = meanBStreamDup0 depth = 3

  hls::stream<Hist::VarSumPkt> varSumAStream;
  hls::stream<Hist::VarSumPkt> varSumBStream;

  // Define tasks
  sumHist(histAStream, histABlockStream, statsAStream);
  sumHist(histBStream, histBBlockStream, statsBStream);

  calcMeanAndInv(statsAStream, meanAStream, countInvPairAStream);
  calcMeanAndInv(statsBStream, meanBStream, countInvPairBStream);

  duplicateStream(meanAStream, meanAStreamDup0, meanAStreamDup1);
  duplicateStream(meanBStream, meanBStreamDup0, meanBStreamDup1);

  calcVarSum(histABlockStream, meanAStreamDup1, varSumAStream);
  calcVarSum(histBBlockStream, meanBStreamDup1, varSumBStream);

  calcTval(meanAStreamDup0, meanBStreamDup0, varSumAStream, varSumBStream,
           countInvPairAStream, countInvPairBStream, outputStream);
}