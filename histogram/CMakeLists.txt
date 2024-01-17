add_library(Histogram histogram.cpp)
target_include_directories(Histogram PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(tests)