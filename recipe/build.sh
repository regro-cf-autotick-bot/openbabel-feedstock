#!/bin/bash

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

# Install activation scripts so BABEL_DATADIR / BABEL_LIBDIR point into the
# conda prefix at runtime (the compiled-in paths are not reliably found on
# macOS, causing format plugins to fail to load).
for change in activate deactivate; do
    mkdir -p "${PREFIX}/etc/conda/${change}.d"
    sed "s|@PKG_VERSION@|${PKG_VERSION}|g" "${RECIPE_DIR}/${change}.sh" \
        > "${PREFIX}/etc/conda/${change}.d/${PKG_NAME}_${change}.sh"
done
