#!/bin/sh
# Restore whatever BABEL_DATADIR / BABEL_LIBDIR were set to before activation.
export BABEL_DATADIR="${_CONDA_SET_BABEL_DATADIR}"
export BABEL_LIBDIR="${_CONDA_SET_BABEL_LIBDIR}"
unset _CONDA_SET_BABEL_DATADIR
unset _CONDA_SET_BABEL_LIBDIR
# If they were previously unset, drop them rather than leaving empty values.
[ -z "${BABEL_DATADIR}" ] && unset BABEL_DATADIR
[ -z "${BABEL_LIBDIR}" ] && unset BABEL_LIBDIR
