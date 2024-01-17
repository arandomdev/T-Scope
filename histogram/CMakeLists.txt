add_library(Histogram SHARED histogram.cpp)
target_include_directories(Histogram PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(python)
add_subdirectory(tests)