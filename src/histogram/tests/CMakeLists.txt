add_executable(decimate_test decimate_test.cpp)
target_link_libraries(decimate_test PRIVATE Histogram)
add_test(NAME decimate_test COMMAND $<TARGET_FILE:decimate_test>)

add_executable(scale_test scale_test.cpp)
target_link_libraries(scale_test PRIVATE Histogram)
add_test(NAME scale_test COMMAND $<TARGET_FILE:scale_test>)

add_executable(trace_length_test trace_length_test.cpp)
target_link_libraries(trace_length_test PRIVATE Histogram)
add_test(NAME trace_length_test COMMAND $<TARGET_FILE:trace_length_test>)

add_executable(trace_collection_test trace_collection_test.cpp)
target_link_libraries(trace_collection_test PRIVATE Histogram)
add_test(NAME trace_collection_test COMMAND $<TARGET_FILE:trace_collection_test>)