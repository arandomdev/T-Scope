#include "tTest.h"

void tTest(hls::stream<streamPkt>&A,
	     hls::stream<streamPkt>&B,
		 hls::stream<streamPkt>&C) {
#pragma HLS INTERFACE mode=axis port=A,B,C
#pragma HLS INTERFACE mode=s_axilite port=return
	streamPkt pktA, pktB;
	ap_uint<32> famA[BINNUM];
#pragma HLS ARRAY_PARTITION variable=famA type=complete // array partitions completely into registers
#pragma HLS BIND_STORAGE variable=famA type=RAM_S2P imple=BRAM // RAM_S2P -> dual-port RAM (read on one port, write on other port)
	ap_uint<32> famB[BINNUM];
#pragma HLS ARRAY_PARTITION variable=famB type=complete
#pragma HLS BIND_STORAGE variable=famB type=RAM_S2P imple=BRAM
	ap_uint<51> sumA = 0; // in MATLAB:  log2(sum((ones(1,NUMBINS) * 2^32) .* quantValues)) = 51
	ap_uint<40> numDataA = 0; // max counter val * BINNUM = 2^32 * 2^8 = 2^40 -> 40 bits
	ap_uint<51> sumB = 0;
	ap_uint<40> numDataB = 0;
	ap_uint<12> quantValue = 8; // 8 <= quantValue <= 4088 <= 2^12 = 4096
	ap_uint<8> i;

	for (i = 0; i<BINNUM;i++) {
		pktA = A.read();
		pktB = B.read();
		famA[i] = pktA.data;
		famB[i] = pktB.data;
		sumA += (pktA.data * quantValue);
		numDataA += pktA.data;
		sumB += (pktB.data * quantValue);
		numDataB += pktB.data;
		quantValue += QUANTINC;
	}
	ap_ufixed<20,12> meanA = sumA/numDataA; // 12 int, 8 decimal bits, unsigned
	ap_ufixed<20,12> meanB = sumB/numDataB;
	ap_ufixed<71,63> varsumA = 0; // in MATLAB: log2(sum(((quantValues - (ones(1,256) * 8)).^2) .* (ones(1,NUMBINS) * 2^32))) = 62.4
	ap_ufixed<71,63> varsumB = 0;
	quantValue = 8;

	for (i = 0; i<BINNUM; i++) {
		varsumA += ((quantValue - meanA)^2) * famA[i];
		varsumB += ((quantValue - meanB)^2) * famB[i];
		quantValue += QUANTINC;
	}
	//in MATLAB: log2(sum(((quantValues(:,:,1) - (ones(1,256) * 8)).^2) .* (ones(1,256) * 2^32)) / sum((ones(1,256) * 2^32))) = 22.4
	ap_ufixed<31,23> varA = varsumA/numDataA;
	ap_ufixed<31,23> varB = varsumB/numDataB;

	ap_ufixed<32,10> t = abs((meanA - meanB)/(sqrt(((varA^2)/numDataA) + ((varB^2)/numDataB))));

	pktA.data = t;
	C.write(pktA);
}
