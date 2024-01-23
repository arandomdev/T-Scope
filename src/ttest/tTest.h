#include "ap_axi_sdata.h"
#include "hls_stream.h"
#include "hls_math.h"
#include "ap_int.h"
#include "ap_fixed.h"

#define BINNUM 256
typedef ap_axis<32,2,5,6> streamPkt;

void tTest(hls::stream<streamPkt>&A,hls::stream<streamPkt>&B,hls::stream<streamPkt>&C);
