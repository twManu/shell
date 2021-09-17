# use ${ROOTFS} of jetson sample_rootfs (copy from nano success)
# delete config.cache
# qtbase/mkspecs/devices/linux-jetson-tx1-g++/qmake.conf
#    modify eglfs_x11 as eglfs_kms_egldevice
# set ROOTFS
# set PATH to gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu (jetson developer)

#test this
./configure -shared -c++std c++14 -opensource -release -recheck-all --confirm-license\
 -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu-\
 -sysroot ${ROOTFS} -nomake tests -prefix /usr/local/qt5 -extprefix /usr/local/qt5 -hostprefix /usr/local/qt5 -skip webview -skip qtwebengine -opengl es2




