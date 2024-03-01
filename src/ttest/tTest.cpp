#include "tTest.h"
#include <assert.h>
#include <hls_math.h>
#include <hls_stream.h>
#include <hls_streamofblocks.h>

void sumHist(hls::stream<Hist::InputPkt> &histStream,
             hls::stream_of_blocks<Hist::Block> &histBlockStream,
             hls::stream<Hist::SumPkt> &sumStream,
             hls::stream<Hist::CountPkt> &countStream) {
  bool eos = false;

  Hist::SumPkt sumPkt;
  Hist::CountPkt countPkt;

StreamLoop:
  while (!eos) {
    hls::write_lock<Hist::Block> histBlockLock(histBlockStream);
    sumPkt.data = 0;
    countPkt.data = 0;

  SumLoop:
    for (int i = 0; i < N_BINS; i += 2) {
      auto inputPkt = histStream.read();
      Hist::InputData data{.raw = inputPkt.data};

      histBlockLock[i / 2] = data;

      sumPkt.data += (data.a * i) + (data.b * (i + 1));
      countPkt.data += data.a + data.b;

      bool last = inputPkt.last;
      sumPkt.last = last;
      countPkt.last = last;
      eos = last;
    }

    sumStream.write(sumPkt);
    countStream.write(countPkt);
  }
}

void calcMean(hls::stream<Hist::SumPkt> &sumStream,
              hls::stream<Hist::CountPkt> &countStream,
              hls::stream<Hist::MeanPkt> &meanStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    Hist::SumPkt sumPkt = sumStream.read();
    Hist::CountPkt countPkt = countStream.read();

    Hist::CountInv countInv = countPkt.data
                                  ? (Hist::CountInv)(1) / countPkt.data
                                  : (Hist::CountInv)(0);

    Hist::Mean mean = sumPkt.data * countInv;

    assert(sumPkt.last == countPkt.last);
    meanStream.write({mean, sumPkt.last});
    eos = sumPkt.last;
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

template <typename T>
void duplicateStream(hls::stream<T> &input, hls::stream<T> &a,
                     hls::stream<T> &b, hls::stream<T> &c) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    T pkt = input.read();
    eos = pkt.last;
    a.write(pkt);
    b.write(pkt);
    c.write(pkt);
  }
}

void calcMeanDiff(hls::stream<Hist::MeanPkt> &meanAStream,
                  hls::stream<Hist::MeanPkt> &meanBStream,
                  hls::stream<Hist::MeanPkt> &meanDiffStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    Hist::MeanPkt aPkt = meanAStream.read();
    Hist::MeanPkt bPkt = meanBStream.read();

    Hist::Mean a = aPkt.data;
    Hist::Mean b = bPkt.data;

    Hist::Mean diff = (a > b) ? (Hist::Mean)(a - b) : (Hist::Mean)(b - a);

    assert(aPkt.last == bPkt.last);
    meanDiffStream.write({diff, aPkt.last});
    eos = aPkt.last;
  }
}

void calcVarSum(hls::stream_of_blocks<Hist::Block> &histBlockStream,
                hls::stream<Hist::MeanPkt> &meanStream,
                hls::stream<Hist::VarSumPkt> &varSumStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    hls::read_lock<Hist::Block> histBlockLock(histBlockStream);
    Hist::MeanPkt meanPkt = meanStream.read();
    Hist::VarSum sum = 0;

  SumLoop:
    for (int i = 0; i < N_BINS; i += 2) {
#pragma HLS PIPELINE
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

void calcVar(hls::stream<Hist::VarSumPkt> &varSumStream,
             hls::stream<Hist::CountPkt> &countStream,
             hls::stream<Hist::VarPkt> &varStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
    Hist::VarSumPkt varSumPkt = varSumStream.read();
    Hist::CountPkt countPkt = countStream.read();

    Hist::CountInv countInv =
        (countPkt.data > 1)
            ? (Hist::CountInv)(1) / (Hist::Count)(countPkt.data - 1)
            : (Hist::CountInv)(0);

    Hist::Var var = varSumPkt.data * countInv;

    assert(varSumPkt.last == countPkt.last);
    varStream.write({var, varSumPkt.last});
    eos = varSumPkt.last;
  }
}

void calcTval(hls::stream<Hist::MeanPkt> &meanDiffStream,
              hls::stream<Hist::VarPkt> &varAStream,
              hls::stream<Hist::VarPkt> &varBStream,
              hls::stream<Hist::CountPkt> &countAStream,
              hls::stream<Hist::CountPkt> &countBStream,
              hls::stream<Hist::OutputPkt> &outputStream) {
  bool eos = false;

StreamLoop:
  while (!eos) {
#pragma HLS ALLOCATION operation instances = udiv limit = 1
    Hist::MeanPkt meanDiffPkt = meanDiffStream.read();
    Hist::VarPkt varAPkt = varAStream.read();
    Hist::VarPkt varBPkt = varBStream.read();
    Hist::CountPkt countAPkt = countAStream.read();
    Hist::CountPkt countBPkt = countBStream.read();

    Hist::CountInv countAInv = countAPkt.data
                                   ? (Hist::CountInv)(1) / countAPkt.data
                                   : (Hist::CountInv)(0);
    Hist::CountInv countBInv = countBPkt.data
                                   ? (Hist::CountInv)(1) / countBPkt.data
                                   : (Hist::CountInv)(0);

    // divide by count
    Hist::Var divA = varAPkt.data * countAInv;
    Hist::Var divB = varBPkt.data * countBInv;

    // Add
    Hist::Var divSum = divA + divB;

    // Sqrt
    float denom = sqrtf(divSum.to_float());
    float denomInv = denom ? 1 / denom : 0;

    // divide
    float tval = (float)meanDiffPkt.data * denomInv;

    // Output
    bool last = meanDiffPkt.last;
    assert((last == varAPkt.last) && (last == varBPkt.last) &&
           (last == countAPkt.last) && (last == countBPkt.last));

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
  hls::stream_of_blocks<Hist::Block> histABlockStream;
  hls::stream_of_blocks<Hist::Block> histBBlockStream;
  hls::stream<Hist::SumPkt> sumAStream;
  hls::stream<Hist::SumPkt> sumBStream;
  hls::stream<Hist::CountPkt> countAStream;
  hls::stream<Hist::CountPkt> countBStream;
  hls::stream<Hist::CountPkt> countAStreamDup0;
  hls::stream<Hist::CountPkt> countBStreamDup0;
  hls::stream<Hist::CountPkt> countAStreamDup1;
  hls::stream<Hist::CountPkt> countBStreamDup1;
  hls::stream<Hist::CountPkt> countAStreamDup2;
  hls::stream<Hist::CountPkt> countBStreamDup2;

#pragma HLS BIND_STORAGE variable = histABlockStream type = RAM_2P impl = bram
#pragma HLS BIND_STORAGE variable = histBBlockStream type = RAM_2P impl = bram

  hls::stream<Hist::MeanPkt> meanAStream;
  hls::stream<Hist::MeanPkt> meanBStream;
  hls::stream<Hist::MeanPkt> meanAStreamDup0;
  hls::stream<Hist::MeanPkt> meanBStreamDup0;
  hls::stream<Hist::MeanPkt> meanAStreamDup1;
  hls::stream<Hist::MeanPkt> meanBStreamDup1;

  hls::stream<Hist::MeanPkt> meanDiffStream;

  hls::stream<Hist::VarSumPkt> varSumAStream;
  hls::stream<Hist::VarSumPkt> varSumBStream;

  hls::stream<Hist::VarPkt> varAStream;
  hls::stream<Hist::VarPkt> varBStream;

  // Define tasks
  sumHist(histAStream, histABlockStream, sumAStream, countAStream);
  sumHist(histBStream, histBBlockStream, sumBStream, countBStream);
  duplicateStream(countAStream, countAStreamDup0, countAStreamDup1,
                  countAStreamDup2);
  duplicateStream(countBStream, countBStreamDup0, countBStreamDup1,
                  countBStreamDup2);

  calcMean(sumAStream, countAStreamDup0, meanAStream);
  calcMean(sumBStream, countBStreamDup0, meanBStream);
  duplicateStream(meanAStream, meanAStreamDup0, meanAStreamDup1);
  duplicateStream(meanBStream, meanBStreamDup0, meanBStreamDup1);

  calcMeanDiff(meanAStreamDup0, meanBStreamDup0, meanDiffStream);

  calcVarSum(histABlockStream, meanAStreamDup1, varSumAStream);
  calcVarSum(histBBlockStream, meanBStreamDup1, varSumBStream);

  calcVar(varSumAStream, countAStreamDup1, varAStream);
  calcVar(varSumBStream, countBStreamDup1, varBStream);

  calcTval(meanDiffStream, varAStream, varBStream, countAStreamDup2,
           countBStreamDup2, outputStream);
}