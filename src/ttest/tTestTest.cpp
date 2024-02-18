#include "tTest.h"
#include "tTestVectors.h"

int main() {
	int err = 0;
	float C;
	hls::stream<streamPkt> Astream;
	hls::stream<streamPkt> Bstream;
	streamPkt dataStreamA;
	streamPkt dataStreamB;

	for (int i = 0; i < BINNUM ; i++) {
		dataStreamA.data = hist3[i];
		dataStreamA.keep = -1;
		dataStreamB.data = hist4[i];
		dataStreamB.keep = -1;
		if (i < (BINNUM-1)) {
			dataStreamA.last = 0;
			dataStreamB.last = 0;
		} else {
			dataStreamA.last = 1;
			dataStreamB.last = 1;
		}
		Astream.write(dataStreamA);
		Bstream.write(dataStreamB);
	}

	tTest(Astream,Bstream,&C);
	printf("T Val = %f \n", C);
	return err;
}
