#include "tTest.h"
#include "tTestVectors.h"
#include "types.h"

int main() {
  hls::stream<Hist::BinPkt> histAStream;
  hls::stream<Hist::BinPkt> histBStream;
  hls::stream<Hist::OutPkt> outputStream;
  Hist::BinPkt histAPkt;
  Hist::BinPkt histBPkt;

  // Write hist 0
  for (int i = 0; i < N_BINS; i++) {
    histAPkt.data = histA0[i];
    histBPkt.data = histB0[i];
    histAPkt.last = 0;
    histBPkt.last = 0;
    histAStream.write(histAPkt);
    histBStream.write(histBPkt);
  }

  // Write hist 1
  for (int i = 0; i < N_BINS; i++) {
    histAPkt.data = histA1[i];
    histBPkt.data = histB1[i];
    if (i < (N_BINS - 1)) {
      histAPkt.last = 0;
      histBPkt.last = 0;
    } else {
      histAPkt.last = 1;
      histBPkt.last = 1;
    }
    histAStream.write(histAPkt);
    histBStream.write(histBPkt);
  }

  tTest(histAStream, histBStream, outputStream);
  Hist::OutPkt outPkt0 = outputStream.read();
  Hist::OutPkt outPkt1 = outputStream.read();
  Hist::DoubleIntConverter c0;
  Hist::DoubleIntConverter c1;
  c0.i = outPkt0.data;
  c1.i = outPkt1.data;
  printf("T Val = {%f, %f}\n", c0.d, c1.d);
  return 0;
}
