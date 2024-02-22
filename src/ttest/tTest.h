#ifndef __TTEST_H__
#define __TTEST_H__

#include "types.h"
#include <hls_stream.h>

void tTest(hls::stream<Hist::BinPkt> &histAStream,
             hls::stream<Hist::BinPkt> &histBStream,
             hls::stream<Hist::OutPkt> &outputStream);

#endif // __TTEST_H__