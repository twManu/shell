# almost follow chinese way (no KHR) but I also create symblink as western way 
# sudo apt install symlinks nfs-kernel-server
# sudo vi /etc/exports:
#   <add> / *(ro,fsid=root,no_root_squash,nohide,insecure,no_subtree_check)
# sudo exportfs -a
# sudo symlinks -c -r /
# delete config.cache

#test this
./configure -shared -c++std c++14 -opensource -release -recheck-all --confirm-license\
 -device linux-jetson-tx1-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu-\
 -sysroot / -nomake tests -prefix /usr/local/qt5 -extprefix /usr/local/qt5 -hostprefix /usr/local/qt5 -skip webview -skip qtwebengine -opengl es2


#works
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


