#include "tTest.h"
#include <assert.h>
#include <hls_math.h>
#include <hls_stream.h>
#include <hls_streamofblocks.h>
#include <iostream>

void sumHist(hls::stream<Hist::BinPkt> &histStream,
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
    for (int i = 0; i < N_BINS; i++) {
#pragma HLS PIPELINE II = 2
      Hist::BinPkt input = histStream.read();

      histBlockLock[i] = input.data;
      sumPkt.data += input.data * i;
      countPkt.data += input.data;

      sumPkt.last = input.last;
      countPkt.last = input.last;
      eos = input.last;
    }

    sumStream.write(sumPkt);
    countStream.write(countPkt);
  }
}

void calcMean(hls::stream<Hist::SumPkt> &sumStream,
              hls::stream<Hist::CountPkt> &countStream,
              hls::stream<Hist::MeanPkt> &meanStream) {
  bool eos = false;

  while (!eos) {
    Hist::SumPkt sumPkt = sumStream.read();
    Hist::CountPkt countPkt = countStream.read();

    Hist::Mean mean;
    if (countPkt.data) {
      mean = (ap_ufixed<HIST_SUM_SIZE + FRAC_BITS, HIST_SUM_SIZE>)sumPkt.data /
             countPkt.data;
    } else {
      mean = 0;
    }

    assert(sumPkt.last == countPkt.last);
    meanStream.write({mean, sumPkt.last});
    eos = sumPkt.last;
  }
}

template <typename T>
void duplicateStream(hls::stream<T> &input, hls::stream<T> &a,
                     hls::stream<T> &b) {
  bool eos = false;
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

  OpLoop:
    for (int i = 0; i < N_BINS; i++) {
#pragma HLS PIPELINE
      Hist::CenteredWeight centeredWeight = i - meanPkt.data;
      Hist::CenteredWeightSquared centeredWeightSquared =
          centeredWeight * centeredWeight;
      sum += centeredWeightSquared * histBlockLock[i];
    }

    eos = meanPkt.last;
    varSumStream.write({sum, meanPkt.last});
  }
}

void calcVar(hls::stream<Hist::VarSumPkt> &varSumStream,
             hls::stream<Hist::CountPkt> &countStream,
             hls::stream<Hist::VarPkt> &varStream) {
  bool eos = false;
  while (!eos) {
    Hist::VarSumPkt varSumPkt = varSumStream.read();
    Hist::CountPkt countPkt = countStream.read();

    Hist::Var var;
    if (countPkt.data > 1) {
      var = (ap_ufixed<56 + FRAC_BITS, 56>)varSumPkt.data / (countPkt.data - 1);
    } else {
      var = 0;
    }

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
              hls::stream<Hist::TvalPkt> &tvalStream) {
  bool eos = false;
  while (!eos) {
#pragma HLS ALLOCATION operation instances = udiv limit = 1
    Hist::MeanPkt meanDiffPkt = meanDiffStream.read();
    Hist::VarPkt varAPkt = varAStream.read();
    Hist::VarPkt varBPkt = varBStream.read();
    Hist::CountPkt countAPkt = countAStream.read();
    Hist::CountPkt countBPkt = countBStream.read();

    // divide by count
    Hist::Var divA;
    Hist::Var divB;
    if (countAPkt.data) {
      divA = varAPkt.data / countAPkt.data;
    } else {
      divA = 0;
    }
    if (countBPkt.data) {
      divB = varBPkt.data / countBPkt.data;
    } else {
      divB = 0;
    }

    // Add
    Hist::Var divSum = divA + divB;

    // Sqrt
    Hist::TvalDenom denom = sqrt(divSum.to_double());

    // divide
    Hist::Tval tval;
    if (denom) {
      tval = meanDiffPkt.data / denom;
    } else {
      tval = 0;
    }

    // Output
    assert((meanDiffPkt.last == varAPkt.last) &&
           (meanDiffPkt.last == varBPkt.last) &&
           (meanDiffPkt.last == countAPkt.last) &&
           (meanDiffPkt.last == countBPkt.last));
    tvalStream.write({tval, meanDiffPkt.last});
    eos = meanDiffPkt.last;
  }
}

void convertToOutput(hls::stream<Hist::TvalPkt> &tvalStream,
                     hls::stream<Hist::OutPkt> &outputStream) {
  bool eos = false;
  Hist::DoubleIntConverter conv;

  while (!eos) {
    Hist::TvalPkt tvalPkt = tvalStream.read();
    conv.d = tvalPkt.data.to_double();

    Hist::OutPkt outPkt;
    outPkt.data = conv.i;
    outPkt.last = tvalPkt.last;
    outPkt.keep = -1;
    outputStream.write(outPkt);
    eos = tvalPkt.last;
  }
}

/// @brief Top function for core
void tTest(hls::stream<Hist::BinPkt> &histAStream,
           hls::stream<Hist::BinPkt> &histBStream,
           hls::stream<Hist::OutPkt> &outputStream) {
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

  hls::stream<Hist::TvalPkt> tvalStream;

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
           countBStreamDup2, tvalStream);

  convertToOutput(tvalStream, outputStream);
}