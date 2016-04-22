#!/bin/bash

#for host
#
#sudo apt-get install xfce4 xfce4-terminal virt-manager libvirt-bin qemu-system qemu-kvm linux-image-extra-virtual minicom
#sudo echo 'auto eth0' >>/etc/network/interfaces
#sudo echo 'iface eth0 inet manual' >>/etc/network/interfaces
#sudo echo 'auto br0' >>/etc/network/interfaces
#sudo echo 'iface br0 inet dhcp' >>/etc/network/interfaces
#sudo echo '\tbridge_ports eth0' >>/etc/network/interfaces
#sudo echo '\tbridge_stp off' >>/etc/network/interfaces
#sudo echo '\tbridge_fd 0' >>/etc/network/interfaces
#sudo echo '\tbridge_maxwait 0' >>/etc/network/interfaces

sudo apt-get install -y filezilla vsftpd tftpd-hpa g++ vim git gitk\
	synaptic ssh meld dos2unix
sudo apt-get install -y nfs-common nfs-kernel-server
sudo echo '/home/aten-3a00/ti *(rw,sync,no_subtree_check)' >>/etc/exports
echo 'export EDITOR=vim' >>~/.bashrc
