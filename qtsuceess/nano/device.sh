#!/bin/bash
sudo apt update
sudo apt download libgles2-mesa-dev libegl1-mesa-dev
mkdir GLES EGL
pushd GLES; ar x ../libgles2*.deb; tar xf data.tar.xz; sudo cp -a usr/include/GLES* /usr/include; popd
pushd EGL; ar x ../libegl1*.deb; tar xf data.tar.xz; sudo cp -a usr/include/EGL /usr/include; popd
cp -a /usr/src/nvidia/graphics_demos/include/KHR /usr/include

sudo apt install libglm-dev libinput-dev libudev-dev symlinks libxkbcommon-dev ".*libxcb.*" libxrender-dev libxi-dev libfontconfig1-dev
pushd /; sudo symlinks -c -r / ;tar cjf ~/nano441_root.tgz lib usr/include usr/lib usr/local/cuda*; popd
