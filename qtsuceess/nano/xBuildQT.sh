#export ROOTFS=
#export TARGET_ROOTFS=${ROOTFS}
#export CROSS_COMPILE=aarch64-linux-gnu-
#export PATH=~/bin/gcc-xxx/bin:${PATH}

./configure -shared -c++std c++14 -opensource -release -recheck-all --confirm-license -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu- -prefix /home/manu/cross/preqt5 -extprefix /home/manu/cross/extqt5 -hostprefix /home/manu/cross/hostqt5 -skip webview -skip qtwebengine -opengl es2 -sysroot ${ROOTFS}
