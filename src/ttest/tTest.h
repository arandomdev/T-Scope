#define BINNUM 256
#define BINHALF (BINNUM/2)
#define BINQUARTER (BINNUM/4)
#include "ap_axi_sdata.h"
#include "hls_stream.h"
#include "hls_math.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_vector.h"

typedef ap_axiu<32,0,0,0> streamPkt;
typedef ap_uint<32> countType;
typedef ap_uint<47> sumType;
typedef ap_uint<40> numDataType;
typedef ap_uint<1> controlType;
typedef ap_ufixed<16,8> meanType;
typedef ap_ufixed<63,55> varSumType;
typedef ap_ufixed<23,15> varType;
typedef ap_ufixed<32,10> tCalcResultType;
typedef ap_ufixed<54,48> vecMultType;
typedef ap_ufixed<24,16> vecSqType;

struct packet {
    ap_uint<32> data;
    ap_uint<8> num;
    ap_int<1> last;
};

void tTest(hls::stream<streamPkt>&A,hls::stream<streamPkt>&B,tCalcResultType* C);
