cmake_minimum_required(VERSION 3.11)

project("sample-project")

set(DOXYGEN_PROJECT_NAME "XXX Common Module")
set(DOXYGEN_PROJECT_BRIEF "A C++ Library for XXX")
set(DOXYGEN_EXCLUDE_PATTERNS "*/sampleproject/test/*")
set(DOXYGEN_EXCLUDE_SYMBOLS "test")

add_subdirectory("src")

sample_add_clang_tidy(sample-project)

if (SAMPLE_BUILD_TESTS)
    enable_testing()
    add_subdirectory("test")
endif (SAMPLE_BUILD_TESTS)