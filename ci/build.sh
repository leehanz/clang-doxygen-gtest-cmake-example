rm -rf build
echo "================================================================"
printf "\e[93mConfigure CMake\n\e[0m"
CMAKE_COMMAND="cmake"
SOURCE_DIR="../"
BINARY_DIR="../build"

# Extra flags to pass to CMake based on our build configurations.
declare -a cmake_extra_flags

if [[ "${GOOGLE_TEST:-}" == "yes" ]]; then
  cmake_extra_flags+=("-DSAMPLE_BUILD_TESTS=ON")
fi

if [[ "${CLANG_TIDY:-}" = "yes" ]]; then
  cmake_extra_flags+=("-GNinja")
  cmake_extra_flags+=("-DCMAKE_CXX_COMPILER=Clang")
  cmake_extra_flags+=("-DCMAKE_C_COMPILER=Clang")
  cmake_extra_flags+=("-DSAMPLE_BUILD_CLANG_TIDY=ON")
fi

if [[ "${DOXYGEN:-}" = "yes" ]]; then
  cmake_extra_flags+=("-DSAMPLE_BUILD_DOXYGEN=ON")
fi

${CMAKE_COMMAND} \
  -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
  "${cmake_extra_flags[@]+"${cmake_extra_flags[@]}"}" \
  "-S${SOURCE_DIR}" \
  "-B${BINARY_DIR}"

printf "\e[92mFinished CMake config\n\e[0m"
echo "================================================================"
printf "\e[93mstarted build\n\e[0m"
${CMAKE_COMMAND} --build "${BINARY_DIR}" --
printf "\e[92mfinished build\n\e[0m"
echo "================================================================"

# If document generation is enabled, run it now.
if [[ "${DOXYGEN}" == "yes" ]]; then
  printf "\e[93mstarted generating Doxygen documentation\n\e[0m"
  cmake --build "${BINARY_DIR}" --target doxygen-docs
  printf "\e[92mfinished\n\e[0m"
fi
echo "================================================================"