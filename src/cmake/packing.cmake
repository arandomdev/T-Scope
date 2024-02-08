set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})

set(CPACK_SOURCE_IGNORE_FILES ".vscode/;venv/;external/;build/;.git/")

if (CMAKE_CROSSCOMPILING)
    set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
endif()

set(CPACK_DEBIAN_PACKAGE_DEPENDS "python3.${Python_VERSION_MINOR}, python3-numpy, python3-scipy, python3-matplotlib, python3-click")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "ArandomPerson")
include(CPack)