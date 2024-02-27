#include "core_test.h"
#include "tTest.h"
#include "types.h"

#define STARTING_HIST 0

int main() {
  hls::stream<Hist::BinPkt> histAStream;
  hls::stream<Hist::BinPkt> histBStream;
  hls::stream<Hist::OutPkt> outputStream;
  Hist::BinPkt histAPkt;
  Hist::BinPkt histBPkt;

  // Write histograms
  for (int histI = STARTING_HIST; histI < N_HISTS; histI++) {
    for (int i = 0; i < N_BINS; i++) {
      bool last = (histI == N_HISTS - 1) && (i == N_BINS - 1);
      histAPkt.data = histsA[histI][i];
      histBPkt.data = histsB[histI][i];
      histAPkt.last = last;
      histBPkt.last = last;
      histAStream.write(histAPkt);
      histBStream.write(histBPkt);
    }
  }

  tTest(histAStream, histBStream, outputStream);

  for (int i = STARTING_HIST; i < N_HISTS; i++) {
    Hist::OutPkt val = outputStream.read();
    Hist::DoubleIntConverter c;
    c.i = val.data;
    printf("%d: %f -> %f\n", i, tvals[i], c.d);
  }

  return 0;
}
