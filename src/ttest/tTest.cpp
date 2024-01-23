#include "tTest.h"

void tTest(hls::stream<streamPkt>&A,
	     hls::stream<streamPkt>&B,
		 ap_uint<32>* C) {
#pragma HLS INTERFACE mode=axis port=A,B
#pragma HLS INTERFACE s_axilite port=C
#pragma HLS INTERFACE mode=s_axilite port=return
	streamPkt pktA, pktB;
	static ap_uint<32> famA[BINNUM];
#pragma HLS BIND_STORAGE variable=famA type=RAM_S2P impl=BRAM // RAM_S2P -> dual-port RAM (read on one port, write on other port)
	static ap_uint<32> famB[BINNUM];
#pragma HLS BIND_STORAGE variable=famB type=RAM_S2P impl=BRAM
	ap_uint<47> sumA = 0; // in MATLAB:  log2(sum((ones(1,NUMBINS) * 2^32) .* quantValues)) = 47
	ap_uint<40> numDataA = 0; // max counter val * BINNUM = 2^32 * 2^8 = 2^40 -> 40 bits
	ap_uint<47> sumB = 0;
	ap_uint<40> numDataB = 0;
	ap_uint<9> i;
	while (1) {
		pktA = A.read();
		famA[i] = pktA.data.to_int();
		if (pktA.last) {
			break;
		}
	}
	while (1) {
		pktB = B.read();
		famB[i] = pktB.data.to_int();
		if (pktB.last) {
			break;
		}
	}
	if (pktB.last && pktA.last) {
		for (i = 0;i<BINNUM;i++) {
			sumA += famA[i] * i;
			numDataA += famA[i];
			sumB += famB[i] * i;
			numDataB += famB[i];
		}
		ap_ufixed<16,8> meanA = sumA/numDataA; // 8 int, 8 decimal bits, unsigned
		ap_ufixed<16,8> meanB = sumB/numDataB;
		ap_ufixed<16,8> meanDiff = meanA-meanB;
		ap_ufixed<63,55> varsumA = 0; // in MATLAB: log2(sum(((quantValues - (ones(1,256) * 8)).^2) .* (ones(1,NUMBINS) * 2^32))) = 55
		ap_ufixed<63,55> varsumB = 0;
		for (i = 0; i<BINNUM; i++) {
			varsumA += ((i - meanA)^2) * famA[i];
			varsumB += ((i - meanB)^2) * famB[i];
		}
		//in MATLAB: log2(sum(((quantValues(:,:,1) - (ones(1,256) * 8)).^2) .* (ones(1,256) * 2^32)) / sum((ones(1,256) * 2^32))) = 14.2
		ap_ufixed<23,15> varA = varsumA/numDataA;
		ap_ufixed<23,15> varB = varsumB/numDataB;
		ap_ufixed<32,10> denom = sqrt(((varA^2)/numDataA) + ((varB^2)/numDataB));
		ap_ufixed<32,10> t = meanDiff/denom;

		C[0] = t;
	}
}
