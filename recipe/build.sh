#!/bin/bash

# Keep Open Babel's format plugins working on macOS.
#
# Open Babel keeps a single shared list of all loaded format plugins (mol2,
# png, inchi, ...). libopenbabel and every plugin .so are supposed to share
# that one list, so a plugin can register itself and obabel can then find it.
#
# The conda-forge compiler adds -fvisibility-inlines-hidden by default. With
# the current clang, that flag makes the shared list private to each library
# instead of shared. Each plugin then registers into its own private copy that
# obabel never looks at: the plugins still load, but `obabel -L formats` comes
# up empty and every conversion fails with "cannot write output format".
# (This is why 3.1.1 worked with the old pinned clang but 3.2.1 does not.)
#
# Dropping the flag on macOS restores the single shared list, so plugins
# register where obabel can find them.
if [[ $(uname) == Darwin ]]; then
    export CXXFLAGS="${CXXFLAGS//-fvisibility-inlines-hidden/}"
fi

cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DWITH_INCHI=ON \
      -DPython_EXECUTABLE=$PYTHON \
      -DPython_FIND_STRATEGY=LOCATION \
      -DPython_ROOT_DIR=$PREFIX \
      -DPYTHON_BINDINGS=ON \
      -DRUN_SWIG=ON \
      .

make #-j${CPU_COUNT}
make install
