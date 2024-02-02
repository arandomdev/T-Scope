add_library(Histogram SHARED histogram.cpp)
target_include_directories(Histogram PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_library(_pyHistogram SHARED bindings.cpp)
target_link_libraries(_pyHistogram PRIVATE Histogram pybind11::headers)
set_target_properties(_pyHistogram PROPERTIES PREFIX "")

add_subdirectory(tests)

install(TARGETS Histogram LIBRARY)

install(TARGETS _pyHistogram
    COMPONENT python
    LIBRARY DESTINATION "lib/python${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}/dist-packages/pyHistogram"
)

install(DIRECTORY
    ${CMAKE_CURRENT_LIST_DIR}/pyHistogram
    DESTINATION "lib/python${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}/dist-packages"
    PATTERN "__pycache__" EXCLUDE
)
