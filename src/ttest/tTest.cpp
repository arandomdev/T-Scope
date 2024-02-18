#include "tTest.h"

void sumStream(hls::stream<streamPkt>& in_stream, countType* fam, sumType* sum, numDataType* numData) {
	streamPkt in_val;
	ap_uint<8> i = 0;
	sumType tempSum = 0;
	numDataType tempNumData = 0;
    do {
#pragma HLS PIPELINE
    	in_val = in_stream.read();
        tempSum += in_val.data * i;
        tempNumData += in_val.data;
        fam[i] = in_val.data;
        i++;
    } while (!in_val.last);
    if (in_val.last) {
    	*sum = tempSum;
    	*numData = tempNumData;
    }
}

void divVal(sumType sum, numDataType numData, meanType* quotient) {
	*quotient = meanType(ap_ufixed<71,47>(sum)/numData);
}

void diff(meanType meanA, meanType meanB, meanType* meanDiff) {
	*meanDiff = (meanA > meanB) ? meanType(meanA - meanB) : meanType(meanB - meanA);
}

void varSum(countType* fam, meanType mean, varSumType* sum) {
	ap_uint<9> i;
	varSumType tmpSum = 0;
	ap_fixed<17,9> tmp1[BINNUM];
	vecMultType tmp2[BINNUM];
	for (i = 0; i < BINNUM; i++) {
#pragma HLS PIPELINE
		tmp1[i] = i - mean;
		tmp2[i] = (vecSqType(tmp1[i] * tmp1[i])) * fam[i];
		tmpSum += tmp2[i];
	}
	if (i == BINNUM) {
		*sum = tmpSum;
	}
}

void tCalc1(varSumType varSum, numDataType numData, tCalcResultType1* out) {
#pragma HLS DATAFLOW
	ap_ufixed<64,23> num = varSum/(numDataType(numData - 1));
	*out = tCalcResultType1(num/numData);
}

void tCalc2(tCalcResultType1 tCalc1ResultA, tCalcResultType1 tCalc1ResultB, meanType meanDiff, tResult* t) {
#pragma HLS DATAFLOW
	tCalcResultType2 denom;
	tCalcResultType1 sum = tCalc1ResultA + tCalc1ResultB;
	fxp_sqrt(denom, sum);
	*t = tResult(meanDiff/denom);
}

void tTest(hls::stream<streamPkt>&A,
	     hls::stream<streamPkt>&B,
		 float* C) {
#pragma HLS INTERFACE mode=axis port=A,B
#pragma HLS INTERFACE mode=m_axi port=C depth=1 num_read_outstanding=1 max_read_burst_length=1 num_write_outstanding=1 max_write_burst_length=1 offset=slave
#pragma HLS interface mode=s_axilite port=C
#pragma HLS INTERFACE mode=s_axilite port=return
#pragma HLS DATAFLOW
	streamPkt pktA, pktB;
	countType famA[BINNUM];
	countType famB[BINNUM];
#pragma HLS BIND_STORAGE variable=famA,famB type=ram_1wnr impl=bram

	sumType sumA = 0, sumB = 0;
	numDataType numDataA = 0, numDataB = 0;
	meanType meanA, meanB, meanDiff;
	varSumType varSumA = 0, varSumB = 0;
	tCalcResultType1 tCalc1ResultA, tCalc1ResultB;
	tResult t;

// data-driven task parallelism
    sumStream(A, famA, &sumA, &numDataA);
	sumStream(B, famB, &sumB, &numDataB);
	if ((numDataA != 0) && (numDataB != 0)) {
		divVal(sumA, numDataA, &meanA);
		divVal(sumB, numDataB, &meanB);
		diff(meanA, meanB, &meanDiff);
		varSum(famA, meanA, &varSumA);
		varSum(famB, meanB, &varSumB);
		tCalc1(varSumA, numDataA, &tCalc1ResultA);
		tCalc1(varSumB, numDataB, &tCalc1ResultB);
		tCalc2(tCalc1ResultA, tCalc1ResultB, meanDiff, &t);
	} else {
		t = 0;
	}
	*C = float(t);
}
