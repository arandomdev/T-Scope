find_package(Python COMPONENTS Interpreter Development)
find_package(pybind11 REQUIRED)

pybind11_add_module(HistogramBindings bindings.cpp)
target_link_libraries(HistogramBindings PUBLIC Histogram)