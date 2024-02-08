add_subdirectory(scripts)

install(DIRECTORY
    ${CMAKE_CURRENT_LIST_DIR}/pyTVLA
    DESTINATION "lib/python${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}/dist-packages"
    PATTERN "__pycache__" EXCLUDE
)