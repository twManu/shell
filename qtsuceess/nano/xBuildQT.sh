#export ROOTFS=~/cross/nano_441
#export TARGET_ROOTFS=${ROOTFS}
#export CROSS_COMPILE=aarch64-linux-gnu-
#export PATH=~/bin/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin:${PATH}

./configure -shared -c++std c++14 -opensource -release -recheck-all --confirm-license -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=${CROSS_COMPILE} -extprefix ${ROOTFS}/usr/local/qt5 -hostprefix /home/manu/cross/hostqt5 -skip webview -skip qtwebengine -opengl es2 -sysroot ${ROOTFS}
