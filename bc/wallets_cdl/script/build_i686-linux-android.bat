Setlocal

set HOST_TAG=i686-linux-android
set NDK=%ANDROID_NDK%
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd %batPath%/../../../app/
mkdir dl\x86
cd dl/x86
set outPath=%cd%

set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set BUILD_DUMMY_WASM_BINARY=1
set AR=%TOOLCHAIN%/bin/%HOST_TAG%-ar.exe
set CC=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CXX=%TOOLCHAIN%/bin/%HOST_TAG%28-clang++.cmd
set LINKER=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CARGO_TARGET_I686_LINUX_ANDROID_LINKER=%LINKER%

#rustup default stable-gnu
cd %batPath%/..
cargo build --release --target %HOST_TAG%

cd %batPath%../../target/%HOST_TAG%/release
copy /Y "libwallets_cdl.so" "%outPath%/"

cd %cuPath%

EndLocal
