#!/bin/bash

# Configure CMAKE for macOS SDK path to ensure C++ standard library headers are found
CMAKE_OSX_FLAGS=""
if [[ "$(uname -s)" == "Darwin" ]]; then
  if [[ -n "$CONDA_BUILD_SYSROOT" ]]; then
    CMAKE_OSX_FLAGS="-DCMAKE_OSX_SYSROOT=$CONDA_BUILD_SYSROOT"
  fi
fi

cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DWITH_INCHI=ON \
      -DPython_EXECUTABLE=$PYTHON \
      -DPYTHON_BINDINGS=ON \
      -DRUN_SWIG=ON \
      ${CMAKE_OSX_FLAGS} \
      .

make #-j${CPU_COUNT}
make install
