#ifndef __T_TEST_H__
#define __T_TEST_H__

#define BINNUM 256
#define BINHALF (BINNUM/2)
#define BINQUARTER (BINNUM/4)
#include "ap_axi_sdata.h"
#include "hls_stream.h"
#include "hls_math.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_vector.h"
#include "fxp_sqrt.h"

typedef ap_axiu<32,0,0,0> streamPkt;
typedef ap_uint<32> countType;
typedef ap_uint<47> sumType;
typedef ap_uint<40> numDataType;
typedef ap_ufixed<32,8> meanType;
typedef ap_ufixed<63,55> varSumType;
typedef ap_ufixed<32,14> varType;
typedef ap_ufixed<64,14> tCalcResultType1;
typedef ap_ufixed<64,7> tCalcResultType2;
typedef ap_ufixed<32,4> tResult;
typedef ap_ufixed<54,48> vecMultType;
typedef ap_ufixed<24,16> vecSqType;

struct packet {
    ap_uint<32> data;
    ap_uint<8> num;
    ap_int<1> last;
};

void tTest(hls::stream<streamPkt>&A,hls::stream<streamPkt>&B,float* C);

#endif
