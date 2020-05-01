# delete config.cache
# sudo apt install '.*libxcb.*' libxrender-dev libxi-dev libfontconfig1-dev libudev-dev libxkbcommon-dev
# apt download libgles2-mesa-dev libegl1-mesa-dev
# mkdir GLES EGL
# cd GLES; ar x ../libgles2*.deb; tar xf data.tar.xz
# cd EGL; ar x ../libegl1*.deb; tar xf data.tar.xz
# need to copy KHR as well
# copy to /usr/include
# sudo usermod -a -G input manu //reboot takes effect logout?
# then
# add .bashrc
# *** modify qtbase/mkspecs/devices/linux-jetson-tx1-g++/qmake.conf
# QMAKE_INCDIR_POST remove /usr/include
# change to eglfs_kms_egldevice
# see ../qmake.conf
# ***
#QT_PATH=/usr/local/qt5
#export PATH=${QT_PATH}/bin:$PATH
#export LD_LIBRARY_PATH=${QT_PATH}/lib:${LD_LIBRARY_PATH}


#nano works
./configure -shared -c++std c++14 -opensource -release -recheck-all --confirm-license -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu- -prefix /usr/local/qt5 -extprefix /usr/local/qt5 -hostprefix /usr/local/qt5 -skip webview -skip qtwebengine -opengl es2

#nano fail
./configure -shared -c++std c++14 -opensource -release -recheck-all --confirm-license -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu- -nomake examples -nomake tests -prefix /usr/lib/qt5.14.1 -skip webview -skip qtwebengine -opengl es2

#x86
./configure -shared -c++std c++14 -opensource -release -recheck-all --confirm-license -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=/home/manu/bin/gcc-linaro-6.5.0-2018.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- -sysroot /home/manu/jetson -nomake examples -nomake tests -prefix /usr/local/qt5 -extprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/NanoR32.3.1/qt5 -hostprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/NanoR32.3.1/qt5-host -skip webview -skip qtwebengine -opengl es2

#not this
./configure -shared -c++std c++14 \
 -opensource -release --confirm-license -no-pkg-config \
 -device linux-jetson-tx1-g++ \
 -device-option CROSS_COMPILE=/home/manu/bin/gcc-linaro-6.5.0-2018.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- \
 -sysroot /home/manu/jetson \
 -nomake examples -nomake tests \
 -prefix /usr/local/qt5 \
 -extprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/NanoR32.3.1/qt5 \
 -hostprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/NanoR32.3.1/qt5-host \
 -skip webview -skip qtwebengine -opengl es2

./configure -shared -c++std c++14 \
 -opensource -release --confirm-license -no-pkg-config \
 -device linux-jetson-tx1-g++ \
 -device-option CROSS_COMPILE=/home/manu/bin/gcc-linaro-6.5.0-2018.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- \
 -sysroot /home/manu/Downloads/nano-rootfs \
 -nomake examples -nomake tests \
 -prefix /usr/local/qt5 \
 -extprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/JetsonNano/qt5 \
 -hostprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/JetsonNano/qt5-host \
 -skip webview -skip qtwebengine -opengl es2

./configure -shared -c++std c++14 \
 -opensource -release --confirm-license -no-pkg-config \
 -device linux-jetson-tx1-g++ \
 -device-option CROSS_COMPILE=/home/manu/bin/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- \
 -sysroot /home/manu/Downloads/nano-rootfs \
 -nomake examples -nomake tests \
 -prefix /usr/local/qt5 \
 -extprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/JetsonNano/qt5 \
 -hostprefix /home/manu/Downloads/qt-everywhere-src-5.14.1/JetsonNano/qt5-host \
 -skip webview -skip qtwebengine -opengl es2


