cmake_minimum_required(VERSION 3.11)

add_library(sample-project STATIC 
    "sample.cpp"
)

target_include_directories(sample-project PUBLIC 
    "${PROJECT_SOURCE_DIR}/include"
)