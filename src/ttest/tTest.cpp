#include "tTest.h"

void load(hls::stream<streamPkt>& in_stream, hls::stream<data>& out_stream) {
	streamPkt in_val;
    ap_uint<9> i;
    for (i = 0; i < BINNUM; i++) {
#pragma HLS pipeline II=1
    	in_val = in_stream.read();
    	out_stream.write({in_val.data, i, in_val.last});
    }
}

void sumStream(hls::stream<data>& in_stream, hls::stream<data>& out_stream, sumType* sum, numDataType* numData) {
	data in_val;
	sumType tempSum = 0;
	numDataType tempNumData = 0;
    do {
#pragma HLS PIPELINE
    	in_val = in_stream.read();
        tempSum += in_val.dataS * in_val.num;
        tempNumData += in_val.dataS;
        out_stream.write(in_val);
    } while (!in_val.last);
    if (in_val.last) {
    	*sum = tempSum;
    	*numData = tempNumData;
    }
}

template <typename T> void store(hls::stream<data>& in_stream, T (&fam1), T (&fam2)) {
	data in_val;
	ap_uint<9> i;
	for (i = 0; i < BINNUM; i++) {
#pragma HLS PIPELINE
		in_val = in_stream.read();
		if (in_val.num < BINHALF) {
			fam1[in_val.num] = in_val.dataS;
		} else {
			fam2[in_val.num-BINHALF] = in_val.dataS;
		}
	}
}

template <typename sType, typename qType> void divVal(sType sum, numDataType numData, qType* quotient) {
	if (numData != 0)
		*quotient = qType(sum/numData);
}

void diff(meanType meanA, meanType meanB, meanType* meanDiff) {
	*meanDiff = meanType(meanA - meanB);
}

template <typename T, typename S> void varSum(const T (&fam), const S (&binInd), meanType mean, varSumType* sum) {
	ap_uint<9> i;
	varSumType tmpSum = 0;
	hls::vector<meanType, BINHALF> tmp1;
	vecMultType tmp2[BINHALF];
	for (i = 0; i < BINHALF; i++) {
#pragma HLS PIPELINE II=2
		tmp1[i] = binInd[i] - mean;
		tmp2[i] = (vecSqType(tmp1[i] * tmp1[i])) * fam[i];
		tmpSum += tmp2[i];
	}
	if (i == BINHALF) {
		*sum = tmpSum;
	}
}

void tCalc1(varSumType varSum1, varSumType varSum2, numDataType numData, tCalcResultType* out) {
#pragma HLS DATAFLOW
	varType var;
	varSumType varSum = varSum1 + varSum2;
	divVal(varSum, numData, &var); //in MATLAB: log2(sum(((quantValues(:,:,1) - (ones(1,256) * 8)).^2) .* (ones(1,256) * 2^32)) / sum((ones(1,256) * 2^32))) = 14.2
	*out = tCalcResultType((var^2)/numData); // out wants to be ap_fixed<40, 32>
}

void tCalc2(tCalcResultType tCalc1ResultA, tCalcResultType tCalc1ResultB, meanType meanDiff, tCalcResultType* t) {
#pragma HLS DATAFLOW
	ap_ufixed<32,10> denom;
	denom = sqrt(tCalc1ResultA + tCalc1ResultB);
	*t = tCalcResultType(meanDiff/denom); // t wants to be ap_ufixed<38, 30>
}

void tTest(hls::stream<streamPkt>&A,
	     hls::stream<streamPkt>&B,
		 tCalcResultType* C) {
#pragma HLS INTERFACE mode=axis port=A,B
#pragma HLS INTERFACE m_axi port=C
#pragma HLS INTERFACE s_axilite port=C bundle = control
#pragma HLS INTERFACE s_axilite port=return bundle = control
#pragma HLS DATAFLOW
	streamPkt pktA, pktB;
	hls::vector<ap_uint<32>,BINHALF> famA1; //bit-widths must be <= 4096 for vector operations
	hls::vector<ap_uint<32>,BINHALF> famA2;
	hls::vector<ap_uint<32>,BINHALF> famB1;
	hls::vector<ap_uint<32>,BINHALF> famB2; // RAM_S2P -> dual-port RAM (read on one port, write on other port)
#pragma HLS BIND_STORAGE variable=famA1,famA2,famB1,famB2 type=RAM_S2P impl=BRAM
	sumType sumA = 0, sumB = 0;
	numDataType numDataA = 0, numDataB = 0;
	meanType meanA, meanB, meanDiff; // 8 int, 8 decimal bits, unsigned
	varSumType varSumA1 = 0, varSumA2 = 0, varSumB1 = 0, varSumB2 = 0; // in MATLAB: log2(sum(((quantValues - (ones(1,256) * 8)).^2) .* (ones(1,BINNUMS) * 2^32))) = 55
	tCalcResultType tCalc1ResultA, tCalc1ResultB, t;

// data-driven task parallelism
    hls::stream<data,BINNUM> A1stream;
    hls::stream<data,BINNUM> A2stream;
    hls::stream<data,BINNUM> B1stream;
    hls::stream<data,BINNUM> B2stream;
    load(A, A1stream);
    load(B, B1stream);
    sumStream(A1stream, A2stream, &sumA, &numDataA);
	sumStream(B1stream, B2stream, &sumB, &numDataB);
	store(A2stream, famA1, famA2);
	store(B2stream, famB1, famB2);
	divVal(sumA, numDataA, &meanA);
	divVal(sumB, numDataB, &meanB);
	diff(meanA, meanB, &meanDiff);
	varSum(famA1, bins1, meanA, &varSumA1);
	varSum(famA2, bins2, meanA, &varSumA2);
	varSum(famB1, bins1, meanB, &varSumB1);
	varSum(famB2, bins2, meanB, &varSumB2);
	tCalc1(varSumA1, varSumA2, numDataA, &tCalc1ResultA);
	tCalc1(varSumB1, varSumB2, numDataB, &tCalc1ResultB);
	tCalc2(tCalc1ResultA, tCalc1ResultB, meanDiff, &t);
	*C = t;
}
