#!/bin/bash
sudo apt download libgles2-mesa-dev libegl1-mesa-dev
mkdir GLES EGL
pushd GLES; ar x ../libgles2*.deb; tar xf data.tar.xz; sudo cp -a usr/include/GLES* /usr/include; popd
pushd EGL; ar x ../libegl1*.deb; tar xf data.tar.xz; sudo cp -a usr/include/EGL /usr/include; popd
cp -a /usr/src/nvidia/graphics_demos/include/KHR /usr/include

sudo apt install libinput-dev libudev-dev symlinks
pushd /; sudo symlinks -c -r / ;tar cjf ~/jetson_root.tgz lib usr/include usr/lib usr/local/cuda*; popd
