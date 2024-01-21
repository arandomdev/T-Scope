add_library(pyHistogram SHARED bindings.cpp)
target_link_libraries(pyHistogram PRIVATE Histogram pybind11::headers)
set_target_properties(pyHistogram PROPERTIES PREFIX "")

install(TARGETS pyHistogram
    COMPONENT python
    LIBRARY DESTINATION "lib/python${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}/dist-packages"
)