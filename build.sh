#!/bin/bash
musl_version="1.1.16"

echo "= downloading musl"
curl -LO http://www.musl-libc.org/releases/musl-${musl_version}.tar.gz

echo "= extracting musl"
tar -xf musl-${musl_version}.tar.gz

echo "= building musl"
working_dir=$(pwd)

install_dir=${working_dir}/musl-install

pushd musl-${musl_version}
env CFLAGS="$CFLAGS -Os -ffunction-sections -fdata-sections" LDFLAGS='-Wl,--gc-sections' ./configure --prefix=${install_dir}
make install
popd # musl-${musl-version}

echo "= setting CC to musl-gcc"
export CC=${working_dir}/musl-install/bin/musl-gcc
export CFLAGS="$CFLAGS -static -fPIC"

make

