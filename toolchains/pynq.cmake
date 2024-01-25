set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR armhf)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)

# where is the target environment located
set(CMAKE_FIND_ROOT_PATH "$ENV{CMAKE_SYSROOT}")
set(CMAKE_SYSROOT "$ENV{CMAKE_SYSROOT}")

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Python variables
set(Python_VERSION_MAJOR "3")
set(Python_VERSION_MINOR "10")

set(PYBIND11_PYTHON_VERSION "3.10")
set(PYBIND11_NOPYTHON ON)
set(PYTHON_MODULE_EXTENSION ".so")
include_directories("${CMAKE_SYSROOT}/usr/include/python3.10")