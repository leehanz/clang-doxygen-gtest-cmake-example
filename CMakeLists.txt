# CMakeList.txt : Top-level CMake project file, do global configuration
# and include sub-projects here.
#
cmake_minimum_required(VERSION 3.11)

project("cmake-sample")

option(SAMPLE_BUILD_TESTS "Build all of sample tests." OFF)
option(SAMPLE_BUILD_DOXYGEN "Build doxgen docs" OFF)
option(SAMPLE_BUILD_CLANG_TIDY "Run clang tidy" OFF)

include("cmake/EnableDoxygen.cmake")
include("cmake/EnableClangTidy.cmake")

# Include sub-projects.
add_subdirectory("sampleproject")

if (SAMPLE_BUILD_TESTS)
    enable_testing()
    add_subdirectory("third_party/googletest")
endif (SAMPLE_BUILD_TESTS)

