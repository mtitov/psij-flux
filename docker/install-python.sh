#!/bin/bash

set -ex

[ -z "$1" ] && PY_BASE_VER="3.7" || PY_BASE_VER="$1"

case "$PY_BASE_VER" in
    "3.7")
        PY_VER="3.7.16"
        ;;
    "3.8")
        PY_VER="3.8.16"
        ;;
    "3.9")
        PY_VER="3.9.16"
        ;;
    "3.10")
        PY_VER="3.10.9"
        ;;
    *)
        echo "Provided version is not supported" 1>&2
        exit 1
esac

PY_NAME="Python-$PY_VER"
PY_TARBALL="$PY_NAME.tgz"

cd /tmp
wget -q --no-check-certificate "https://www.python.org/ftp/python/$PY_VER/$PY_TARBALL"
tar xzf "$PY_TARBALL"
cd "/tmp/$PY_NAME"

[ -z "$PY_PREFIX" ] && PY_PREFIX="/usr/local"
[ "$2" == "alternative" ] && INSTALL_CMD="altinstall" || INSTALL_CMD="install"
./configure --enable-shared --prefix="$PY_PREFIX" && make && make $INSTALL_CMD

if [[ "$PY_PREFIX" != "/usr" && "$INSTALL_CMD" != "altinstall" ]]; then
    ln -sf "$PY_PREFIX/bin/python$PY_BASE_VER" "/usr/bin/python3"
    ln -sf "$PY_PREFIX/bin/python$PY_BASE_VER" "/usr/bin/python$PY_BASE_VER"
fi

cd / && rm "/tmp/$PY_TARBALL" && rm -r "/tmp/$PY_NAME"
