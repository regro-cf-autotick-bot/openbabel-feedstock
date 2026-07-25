#!/bin/sh
# Point Open Babel at the data files and format plugins inside this conda
# environment. Without this, obabel relies on the paths compiled into the
# library, which are not reliably relocated on macOS, so format plugins
# (mol2, inchi, png, ...) silently fail to load. See recipe patches
# fix_library_path_search.diff / fix_data_path.diff.
export _CONDA_SET_BABEL_DATADIR="${BABEL_DATADIR:-}"
export _CONDA_SET_BABEL_LIBDIR="${BABEL_LIBDIR:-}"
# BABEL_DATADIR has no version subdir; Open Babel appends the version itself.
export BABEL_DATADIR="${CONDA_PREFIX}/share/openbabel"
# BABEL_LIBDIR is the plugin directory and is used as-is (version included).
export BABEL_LIBDIR="${CONDA_PREFIX}/lib/openbabel/@PKG_VERSION@"
