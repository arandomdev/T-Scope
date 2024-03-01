#ifndef __TTEST_H__
#define __TTEST_H__

#include "types.h"
#include <hls_stream.h>

void tTest(hls::stream<Hist::InputPkt> &histAStream,
           hls::stream<Hist::InputPkt> &histBStream,
           hls::stream<Hist::OutputPkt> &outputStream);

#endif // __TTEST_H__