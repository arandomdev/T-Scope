#include "core_test.h"
#include "tTest.h"
#include "types.h"

#define STARTING_HIST 0
#define N_ITERS 32

int main() {
  hls::stream<Hist::InputPkt> histAStream;
  hls::stream<Hist::InputPkt> histBStream;
  hls::stream<Hist::OutputPkt> outputStream;
  Hist::InputPkt histAPkt;
  Hist::InputPkt histBPkt;

  // Write histograms
  for (int iter = 0; iter < N_ITERS; iter++) {
    for (int binI = 0; binI < N_BINS; binI++) {
      int histI = iter % N_HISTS + STARTING_HIST;
      bool last = (iter == N_ITERS - 1) && (binI == N_BINS - 1);

      histAPkt.data = histsA[histI][binI];
      histBPkt.data = histsB[histI][binI];
      histAPkt.last = last;
      histBPkt.last = last;
      histAStream.write(histAPkt);
      histBStream.write(histBPkt);
    }
  }

  tTest(histAStream, histBStream, outputStream);

  for (int i = 0; i < N_ITERS; i++) {
    auto val = outputStream.read().data;
    printf("%d: %f -> %f\n", i, tvals[i % N_HISTS + STARTING_HIST],
           Hist::DoubleIntConverter::toDouble(val));
  }

  return 0;
}
