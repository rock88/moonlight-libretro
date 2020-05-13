#!/bin/sh

INSTALL_DIR=`pwd`/third_party/libvdpau-tegra
git clone https://github.com/grate-driver/libvdpau-tegra.git libvdpau-tegra_tmp
cd libvdpau-tegra_tmp

# Fix TOOLCHAIN path!
export TOOLCHAIN=/home/rock88/Documents/Lakka-LibreELEC/build.Lakka-L4T.aarch64-2.2-devel/toolchain

export TARGET_CPU="cortex-a57"
export TARGET_CPU_FLAGS="+crypto+crc+fp+simd"
export TARGET_SUBARCH=aarch64
export TARGET_ARCH=aarch64
export TARGET_VARIANT=armv8-a
export TARGET_ABI=eabi
export SIMD_SUPPORT="yes"
export TARGET_KERNEL_ARCH=arm64
export TARGET_NAME=$TARGET_SUBARCH-libreelec-linux-gnu${TARGET_ABI}

export SYSROOT_PREFIX=$TOOLCHAIN/$TARGET_NAME/sysroot
export TARGET_PREFIX=$TOOLCHAIN/bin/$TARGET_NAME-

export HOST_CC=$TOOLCHAIN/bin/host-gcc
export HOST_CXX=$TOOLCHAIN/bin/host-g++

export CC="${TARGET_PREFIX}gcc"
export CXX="${TARGET_PREFIX}g++"
export CPP="${TARGET_PREFIX}cpp"
export LD="${TARGET_PREFIX}ld"
export AS="${TARGET_PREFIX}as"
export AR="${TARGET_PREFIX}ar"
export NM="${TARGET_PREFIX}nm"
export RANLIB="${TARGET_PREFIX}ranlib"

export TARGET_CFLAGS="-mcpu=${TARGET_CPU}${TARGET_CPU_FLAGS} -mabi=lp64 -Wno-psabi -mtune=${TARGET_CPU} -march=${TARGET_VARIANT}${TARGET_CPU_FLAGS}"
export TARGET_LDFLAGS="-mcpu=${TARGET_CPU}${TARGET_CPU_FLAGS}"
export GCC_OPTS="--with-abi=lp64 --with-arch=$TARGET_VARIANT"

export TARGET_CXXFLAGS="$TARGET_CFLAGS"
export CPPFLAGS="$TARGET_CPPFLAGS"
export CFLAGS="$TARGET_CFLAGS"
export CXXFLAGS="$TARGET_CXXFLAGS"
export LDFLAGS="$TARGET_LDFLAGS"

export PKG_CONFIG_PATH=$SYSROOT_PREFIX/usr/lib/pkgconfig

sh autogen.sh --prefix=$INSTALL_DIR --host=$TARGET_NAME --includedir=$SYSROOT_PREFIX/usr/include
make install
cd ..
rm -fr libvdpau-tegra_tmp
