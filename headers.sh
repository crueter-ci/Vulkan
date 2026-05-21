#!/bin/sh -ex

: "${VERSION:=1.4.350.0}"
: "${ARCH:=amd64}"

tag=vulkan-sdk-1.4.350.0
repo=KhronosGroup/Vulkan-Headers
dir="Vulkan-Headers-$tag"
artifact="headers-$tag.tar.gz"
url="https://github.com/$repo/archive/$tag.tar.gz"

[ -f "$artifact" ] || curl -sfL "$url" -o "$artifact"
[ -d "$dir" ] || tar xf "$artifact"

rm -rf build
cmake -S "$dir" -B build -GNinja -DCMAKE_BUILD_TYPE=Release
cmake --build build
cmake --install build --prefix install

cd install
tar czf "vulkan-$ARCH.tar.gz" ./*