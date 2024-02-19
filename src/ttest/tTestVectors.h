#ifndef __TTEST_VECTORS_H__
#define __TTEST_VECTORS_H__

#include "tTest.h"

// t-val = 42.254765
static const uint32_t histA0[N_BINS] = {
    200,   276,   302,   357,   392,   469,   508,   629,   663,   759,   920,
    1012,  1127,  1219,  1325,  1557,  1819,  1979,  2296,  2398,  2720,  3041,
    3297,  3671,  3999,  4317,  4797,  5087,  5540,  5874,  6442,  6956,  7624,
    8207,  8559,  9192,  9828,  10437, 10950, 11586, 12163, 12673, 13476, 13834,
    14502, 14800, 15509, 16122, 16848, 17201, 17523, 17947, 18189, 18644, 18945,
    19388, 19529, 19747, 19886, 20011, 19946, 20021, 19982, 19640, 19450, 19201,
    19244, 18881, 18357, 18080, 17852, 17281, 16697, 16089, 15592, 15119, 14480,
    13843, 13277, 12713, 12019, 11571, 10831, 10295, 9750,  9113,  8595,  8130,
    7368,  6997,  6328,  6044,  5594,  5004,  4711,  4449,  4010,  3582,  3305,
    2890,  2704,  2506,  2220,  1993,  1723,  1599,  1472,  1243,  1138,  1009,
    891,   824,   692,   624,   532,   461,   394,   332,   304,   289,   228,
    206,   153,   137,   113,   106,   84,    80,    52,    63,    39,    33,
    31,    19,    22,    20,    9,     9,     5,     9,     9,     6,     5,
    2,     5,     2,     1,     1,     1,     0,     0,     0,     0,     1,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0};

static const uint32_t histB0[N_BINS] = {
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     1,
    0,     0,     0,     0,     1,     1,     2,     4,     8,     6,     9,
    18,    25,    47,    67,    92,    106,   165,   225,   325,   473,   597,
    762,   1063,  1358,  1759,  2160,  2831,  3543,  4340,  5289,  6604,  8035,
    9419,  10940, 12973, 14794, 17149, 19462, 21660, 24034, 26746, 28885, 31337,
    33399, 35382, 36847, 38114, 38714, 39552, 39973, 39623, 39254, 38248, 36752,
    34884, 33454, 31334, 29274, 26806, 24020, 21647, 19470, 17326, 14938, 12932,
    11071, 9291,  8077,  6564,  5371,  4397,  3537,  2848,  2331,  1798,  1462,
    1009,  775,   528,   476,   341,   261,   165,   153,   96,    62,    44,
    24,    22,    16,    8,     2,     6,     2,     2,     1,     1,     1,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0};

// tval = 0.77006342
static const uint32_t histA1[N_BINS] = {
    0,     0,     0,     0,     0,     0,     0,     3,     1,     0,     2,
    2,     4,     5,     11,    5,     2,     8,     11,    12,    22,    22,
    18,    30,    22,    29,    43,    33,    60,    53,    56,    90,    103,
    119,   120,   155,   196,   202,   225,   275,   315,   406,   439,   467,
    534,   620,   662,   786,   854,   1032,  1134,  1229,  1409,  1580,  1652,
    1926,  2126,  2289,  2528,  2846,  3008,  3393,  3704,  4007,  4423,  4753,
    5081,  5437,  6023,  6235,  6853,  7395,  7825,  8350,  8714,  9291,  10044,
    10470, 10882, 11356, 12136, 12480, 13183, 13880, 14036, 14577, 15139, 15704,
    16226, 16539, 17044, 17415, 17781, 18024, 18148, 18679, 18606, 18918, 19042,
    18904, 18666, 18954, 18903, 18977, 18781, 18326, 18233, 17840, 17795, 17533,
    16976, 16464, 15951, 15859, 15119, 14695, 14135, 13530, 13152, 12815, 12327,
    11606, 10991, 10346, 9819,  9534,  8717,  8124,  7889,  7344,  6790,  6453,
    5842,  5566,  5213,  4801,  4368,  4020,  3744,  3381,  3069,  2855,  2625,
    2298,  2090,  1909,  1713,  1601,  1377,  1259,  1128,  1002,  860,   845,
    682,   637,   517,   476,   396,   344,   307,   256,   242,   214,   172,
    150,   136,   106,   96,    82,    81,    61,    63,    33,    42,    32,
    29,    37,    23,    15,    10,    11,    11,    13,    9,     7,     4,
    1,     2,     2,     2,     2,     3,     2,     1,     1,     0,     1,
    0,     0,     0,     0,     0,     0,     1,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0};

static const uint32_t histB1[N_BINS] = {
    0,     0,     0,     0,     0,     0,     1,     0,     0,     0,     2,
    1,     0,     2,     4,     2,     1,     4,     4,     6,     3,     13,
    17,    20,    17,    18,    24,    23,    33,    36,    45,    50,    58,
    75,    83,    95,    127,   139,   186,   189,   231,   273,   318,   318,
    406,   446,   539,   545,   669,   801,   936,   993,   1158,  1273,  1375,
    1626,  1772,  2021,  2196,  2462,  2648,  2966,  3293,  3570,  4041,  4284,
    4614,  5200,  5564,  5937,  6457,  7031,  7458,  8086,  8375,  9124,  9631,
    10193, 10987, 11425, 11951, 12633, 13378, 13770, 14689, 15213, 15568, 16133,
    16668, 17102, 17556, 18239, 18424, 18864, 19150, 19308, 19340, 19748, 19885,
    20043, 19916, 19845, 19978, 19651, 19485, 19298, 19065, 18996, 18527, 18055,
    17447, 17404, 16543, 16266, 15785, 14852, 14468, 13883, 13240, 12669, 12099,
    11437, 10611, 10103, 9637,  9213,  8658,  8075,  7503,  6970,  6463,  5981,
    5463,  5165,  4581,  4203,  4071,  3632,  3290,  2992,  2664,  2481,  2208,
    1939,  1833,  1583,  1484,  1288,  1119,  1011,  837,   788,   668,   578,
    527,   499,   398,   340,   300,   259,   235,   190,   161,   145,   119,
    102,   80,    78,    61,    40,    42,    41,    38,    23,    26,    19,
    14,    12,    13,    8,     9,     8,     3,     3,     5,     5,     1,
    2,     1,     1,     1,     2,     2,     0,     2,     0,     1,     1,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
    0,     0,     0};

#endif // __TTEST_VECTORS_H__
