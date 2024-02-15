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

template <typename sType, typename qType> void divVal(sType sum, numDataType numData, qType* quotient) {
	if (numData != 0)
		*quotient = qType(sum/numData);
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

void tCalc1(varSumType varSum, numDataType numData, tCalcResultType* out) {
#pragma HLS DATAFLOW
	varType var;
	divVal(varSum, numDataType(numData - 1), &var); //in MATLAB: log2(sum(((quantValues(:,:,1) - (ones(1,256) * 8)).^2) .* (ones(1,256) * 2^32)) / sum((ones(1,256) * 2^32))) = 14.2
	*out = tCalcResultType(var/numData); // out wants to be ap_fixed<40, 32>
}

void tCalc2(tCalcResultType tCalc1ResultA, tCalcResultType tCalc1ResultB, meanType meanDiff, tCalcResultType* t) {
#pragma HLS DATAFLOW
	ap_ufixed<32,10> denom;
	denom = sqrt(double(tCalc1ResultA + tCalc1ResultB));
	*t = tCalcResultType(meanDiff/denom); // t wants to be ap_ufixed<38, 30>
}

void tTest(hls::stream<streamPkt>&A,
	     hls::stream<streamPkt>&B,
		 tCalcResultType* C) {
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
	meanType meanA, meanB, meanDiff; // 8 int, 8 decimal bits, unsigned
	varSumType varSumA = 0, varSumB = 0; // in MATLAB: log2(sum(((quantValues - (ones(1,256) * 8)).^2) .* (ones(1,BINNUMS) * 2^32))) = 55
	tCalcResultType tCalc1ResultA, tCalc1ResultB, t;

// data-driven task parallelism
    sumStream(A, famA, &sumA, &numDataA);
	sumStream(B, famB, &sumB, &numDataB);
	divVal(sumA, numDataA, &meanA);
	divVal(sumB, numDataB, &meanB);
	diff(meanA, meanB, &meanDiff);
	varSum(famA, meanA, &varSumA);
	varSum(famB, meanB, &varSumB);
	tCalc1(varSumA, numDataA, &tCalc1ResultA);
	tCalc1(varSumB, numDataB, &tCalc1ResultB);
	tCalc2(tCalc1ResultA, tCalc1ResultB, meanDiff, &t);
	*C = t;
}
