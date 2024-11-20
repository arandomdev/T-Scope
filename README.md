# T-Scope
Code repository for T-Scope, an MQP project done at WPI.

Contains the following components,
* C-library for the histogram implementation.
* Python bindings for the histogram library.
* T-Test Core.

# Building
CPack is set up so that a DEB package can be created.
PyBind11 is provided via a submodule.

CMake toolchain files are provided for native and cross compilation. When cross compiling, the `CMAKE_SYSROOT` environment variable is expected. Refer to the documentation folder to obtain it.

# Publications and Documentation
* https://ieeexplore.ieee.org/document/10658682
* https://digital.wpi.edu/concern/student_works/028711123?locale=fr
