cmake_minimum_required(VERSION 3.5.0)
project(FPGA_Accelerated_TVLA VERSION 1.0.0 LANGUAGES CXX)

include(CTest)
enable_testing()

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (NOT CMAKE_CROSSCOMPILING)
    find_package(Python COMPONENTS Interpreter Development)
    include_directories(${Python_INCLUDE_DIRS})
    link_directories(${Python_LIBRARY_DIRS})
endif()

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

add_subdirectory(external/pybind11)

add_subdirectory(src)
