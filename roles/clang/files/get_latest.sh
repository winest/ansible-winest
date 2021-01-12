#!/bin/sh
CURR_DIR=$PWD

VERSION=11.0.0

CLANG_SRC=clang-$VERSION.src
CLANG_EXTRA_SRC=clang-tools-extra-$VERSION.src

wget "https://github.com/llvm/llvm-project/releases/download/llvmorg-$VERSION/${CLANG_SRC}.tar.xz"
wget "https://github.com/llvm/llvm-project/releases/download/llvmorg-$VERSION/${CLANG_EXTRA_SRC}.tar.xz"

tar -Jxf "${CLANG_SRC}.tar.xz"
tar -Jxf "${CLANG_EXTRA_SRC}.tar.xz"

mkdir -p "${CLANG_SRC}/tools/extra"
cp -r ${CLANG_EXTRA_SRC}/* "${CLANG_SRC}/tools/extra/"

tar -Jcf "${CLANG_SRC}_new.tar.xz" "${CLANG_SRC}"
rm -f "${CLANG_SRC}.tar.xz"
rm -rf "${CLANG_SRC}"
rm -f "${CLANG_EXTRA_SRC}.tar.xz"
rm -rf "${CLANG_EXTRA_SRC}"
mv "${CLANG_SRC}_new.tar.xz" "${CLANG_SRC}.tar.xz"
