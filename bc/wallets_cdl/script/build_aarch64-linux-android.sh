#！/bin/bash

HOST_TAG=aarch64-linux-android
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

cd $batPath/../../../app/
mkdir dl/arm64-v8a
cd dl/arm64-v8a
outPath=$(pwd)

TOOLCHAIN=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64
export BUILD_DUMMY_WASM_BINARY=1
export AR=$TOOLCHAIN/bin/${HOST_TAG}-ar
export CC=$TOOLCHAIN/bin/${HOST_TAG}28-clang
export CXX=$TOOLCHAIN/bin/${HOST_TAG}28-clang++
export LINKER=$TOOLCHAIN/bin/${HOST_TAG}28-clang
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=$LINKER

#rustup default stable-gnu
cd $batPath/..
cargo build --release --target $HOST_TAG

cd $batPath/../../target/$HOST_TAG/release
cp "libwallets_cdl.so" "$outPath/"

cd $cuPath
