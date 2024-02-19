#include "tTest.h"

void sumStream(hls::stream<streamPkt>& in_stream, hls::stream_of_blocks<blockData>& fam, hls::stream<sumType>& sum, hls::stream<numDataType>& numData, hls::stream<controlType>& done) {
	streamPkt in_val;
	ap_uint<9> i = 0;
	sumType tempSum = 0;
	numDataType tempNumData = 0;
sumStreamLoop1:
    do {
    	hls::write_lock<blockData> famL(fam);
    sumStreamLoop2:
		do {
#pragma HLS PIPELINE
    		in_val = in_stream.read();
    		tempSum += in_val.data * i;
    		tempNumData += in_val.data;
    		famL[i] = in_val.data;
    		i++;
		} while (i < BINNUM);
    	if (i == BINNUM) {
    		numData.write(tempNumData);
    		sum.write(tempSum);
    		done.write(in_val.last);
    		tempSum = 0;
    		tempNumData = 0;
    		i = 0;
    	}
    } while (!in_val.last);
}

void calcMean(hls::stream<sumType>& sum, hls::stream<numDataType>& numData, hls::stream<numDataType>& numDataOut, hls::stream<meanType>& quotient0, hls::stream<meanType>& quotient1, controlType done) {
	do {
		numDataType numDataLocal = numData.read();
		numDataOut.write(numDataLocal);
		meanType quotient = meanType(ap_ufixed<71,47>(sum.read())/numDataLocal);
		quotient0.write(quotient);
		quotient1.write(quotient);
	} while (!done);
}

void diffMeans(hls::stream<meanType>& meanA, hls::stream<meanType>& meanB, hls::stream<meanType>& diff, controlType done) {
	do {
// #pragma HLS PIPELINE ???
		meanType meanALocal = meanA.read();
		meanType meanBLocal = meanB.read();
		meanType meanDiff = (meanALocal > meanBLocal) ? meanType(meanALocal - meanBLocal) : meanType(meanBLocal - meanALocal);
		diff.write(meanDiff);
	} while (!done);
}

void varSum(hls::stream_of_blocks<blockData>& fam, hls::stream<meanType>& mean, hls::stream<varSumType>& sum, controlType done) {
	ap_uint<9> i;
	varSumType tmpSum = 0;
	ap_fixed<17,9> tmp1[BINHALF];
	ap_fixed<17,9> tmp3[BINHALF];
	vecMultType tmp2[BINHALF];
	vecMultType tmp4[BINHALF];
	do {
		hls::read_lock<blockData> famL(fam);
		for (i = 0; i < BINHALF; i++) {
#pragma HLS PIPELINE
			meanType localMean = mean.read();
			tmp1[i] = i - localMean;
			tmp3[i] = i + BINHALF - localMean;
			tmp2[i] = (vecSqType(tmp1[i] * tmp1[i])) * famL[i];
			tmp4[i] = (vecSqType(tmp3[i] * tmp3[i])) * famL[i+BINHALF];
			tmpSum += tmp2[i] + tmp4[i];
		}
		if (i == BINHALF) {
			sum.write(tmpSum);
			tmpSum = 0;
		}
	} while (!done);
}

void tCalc1(hls::stream<varSumType>& varSum, hls::stream<numDataType>& numData, hls::stream<tCalcResultType1>& out, controlType done) {
	do {
// #pragma HLS PIPELINE ????
		numDataType numDataLocal = numData.read();
		ap_ufixed<64,23> num = (varSum.read())/(numDataType(numDataLocal - 1));
		out.write(tCalcResultType1(num/numDataLocal));
	} while (!done);
}

void tCalc2(hls::stream<tCalcResultType1>& tCalc1ResultA, hls::stream<tCalcResultType1>& tCalc1ResultB, hls::stream<meanType>& meanDiff, hls::stream<streamPkt>& t, hls::stream<controlType>& doneA, hls::stream<controlType>& doneB, controlType* done) {
// #pragma HLS DATAFLOW
	controlType localDoneA = 0, localDoneB = 0;
	*done = 0;
	streamPkt result;
	result.keep = 1;
	do {
		tCalcResultType2 denom;
		tCalcResultType1 sum = tCalc1ResultA.read() + tCalc1ResultB.read();
		fxp_sqrt(denom, sum);
		result.data = tResult(meanDiff.read()/denom);
		if (doneA.read()) {
			localDoneA = 1;
		}
		if (doneB.read()) {
			localDoneB = 1;
		}
		if (localDoneA & localDoneB) {
			*done = 1;
		}
		result.last = *done;
		t.write(result);
	} while (!(*done));
}

void tTest(hls::stream<streamPkt>&A,
	     hls::stream<streamPkt>&B,
		 hls::stream<streamPkt>&C) {
#pragma HLS INTERFACE mode=axis port=A,B,C
#pragma HLS INTERFACE mode=s_axilite port=return
#pragma HLS DATAFLOW
	streamPkt pktA, pktB;
	hls::stream_of_blocks<blockData> famA, famB;
#pragma HLS BIND_STORAGE variable=famA,famB type=RAM_1WNR impl=bram
	hls::stream<sumType> sumA, sumB;
	hls::stream<numDataType> numDataA0, numDataB0, numDataA1, numDataB1; // numDataA2, numDataB2;
	hls::stream<meanType> meanA0, meanB0, meanA1, meanB1, meanDiff;
	hls::stream<varSumType> varSumA, varSumB;
	hls::stream<tCalcResultType1> tCalc1ResultA, tCalc1ResultB;
	hls::stream<controlType> doneA, doneB;
	controlType done = 0;

// data-driven task parallelism
    sumStream(A, famA, sumA, numDataA0, doneA); // consume packets
	sumStream(B, famB, sumB, numDataB0, doneB); // produce fam, sum, numData, done
	//if ((numDataA == 0) || (numDataB == 0)) {
	//	t = 0;
	//}
	calcMean(sumA, numDataA0, numDataA1, meanA0, meanA1, done); // consume sum, numData
	calcMean(sumB, numDataB0, numDataB1, meanB0, meanB1, done); // produce numData, 2 mean
	diffMeans(meanA1, meanB1, meanDiff, done); // consume mean, produce meanDiff
	varSum(famA, meanA0, varSumA, done); // consume fam, consume mean
	varSum(famB, meanB0, varSumB, done); // produce varSum
	tCalc1(varSumA, numDataA1, tCalc1ResultA, done); // consume varSum, numData
	tCalc1(varSumB, numDataB1, tCalc1ResultB, done); // produce tCalc1Result
	tCalc2(tCalc1ResultA, tCalc1ResultB, meanDiff, C, doneA, doneB, &done); // consume tCalcResult, meanDiff, done, produce t
}
