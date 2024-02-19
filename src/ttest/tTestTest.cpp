#include "tTest.h"
#include "tTestVectors.h"

int main() {
	int err = 0;
	hls::stream<streamPkt> Astream;
	hls::stream<streamPkt> Bstream;
	hls::stream<streamPkt> Cstream;
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

	tTest(Astream,Bstream,Cstream);
	streamPkt C = Cstream.read();
	fpint k;
	k.ival = C.data;
	printf("T Val = %f \n", k.fval);
	return err;
}
