#!/bin/bash
# Usage: new_install manuchen

#
# in   : S1 - user name to set permision with
#
get_param()
{
        if [ -z "$1" ]; then
                G_USER=`whoami`
        else
                G_USER=$1
        fi
        X64_CPU=`uname -m`
        MY_UID=`id $G_USER | cut -d"=" -f2 | cut -d"(" -f1`
        test -z "$MY_UID" && exit
        echo G_USER = $G_USER, X64_CPU = $X64_CPU, MY_UID = $MY_UID
}


#
# get answer among (y/n/s)
# in	: $1 - string to highligh for user
# out	: g_ANS = 'n' or 's' or default = 'y'
#
get_answer()
{
	MESSAGE=$1
	echo -en "\\033[0;33m"
	echo -en "$MESSAGE (Yes/No/Skip): "
	echo -en "\\033[0;39m"

	read ans

	if [ $ans == 'N' -o $ans == 'n' ]; then
		g_ANS='n'
	elif [ $ans == 'S' -o $ans == 's' ]; then
		g_ANS='s'
	else
		g_ANS='y'
	fi
}


#
# setting .bashrc
#
do_bashrc()
{
	if `grep CVSROOT ~/.bashrc`; then
		get_answer "The bashrc might be updated, continue to process ?"
		if [ $g_ANS == 'n' ]; then
			exit 0
		elif [ $g_ANS == 's' ]; then
			return
		fi
	fi

	##### CVS setting #####
	echo "export CVSROOT=:pserver:manuchen@10.1.9.200:/home/cvsroot" >> ~/.bashrc
	echo "export EDITOR=vim" >> ~/.bashrc

	##### CIFS setting #####
	echo -n "alias lnaver='sudo mount.cifs //avermedia.com/NETLOGON /mnt/aver" >> ~/.bashrc
	echo -n " -o uid=$MY_UID,username=avermedia\\" >> ~/.bashrc
	echo "\\\\a000989'" >> ~/.bashrc

	echo -n "alias lndriver='sudo mount.cifs //10.1.9.247/Driver /mnt/driver" >> ~/.bashrc
	echo -n " -o uid=$MY_UID,username=avermedia\\" >> ~/.bashrc
	echo "\\\\a000989'" >> ~/.bashrc

	#echo -n "alias ln618='sudo mount.cifs //10.1.9.247/b618 /mnt/618" >> ~/.bashrc
	#echo -n " -o uid=$MY_UID,username=avermedia\\" >> ~/.bashrc
	#echo "\\\\a000989'" >> ~/.bashrc

	echo -n "alias lngit='sudo mount.cifs //10.1.9.247/vl/GIT /mnt/git" >> ~/.bashrc
	echo -n " -o uid=$MY_UID,username=avermedia\\" >> ~/.bashrc
	echo "\\\\a000989'" >> ~/.bashrc
	
	#echo -n "alias ln200='sudo mount.cifs //10.1.9.200/manuchen /mnt/200" >> ~/.bashrc
	#echo " -o username=manuchen'" >> ~/.bashrc

	#echo -n "alias lnsrc='sudo mount.cifs //10.1.9.200/Resources /mnt/src" >> ~/.bashrc
	#echo " -o username=manuchen'" >> ~/.bashrc

	#ubuntu 21.10 needs forceuid,forcegid
	#sudo mount.cifs //62.11.20.100/share/git ~/nas -o forceuid,forcegid,uid=$(id -u),gid=$(id -g),username=manu,vers=1.0
	echo "alias goshare='cd /media/sf_share'" >> ~/.bashrc
}


#
# check if application installed well
#
check_app()
{
	CHECKLIST="gitk cifs-utils vim ssh minicom g++ build-essential terminator gparted chromium-browser"
	PURGE_LIST="libreoffice-* firefox"

	#CHECKLIST="cvs git tftp mount.cifs vim ssh kaffeine vlc mplayer minicom v4l2ucp g++ codeblocks"
	for app in $CHECKLIST; do
		test ! `which $app` && echo "$app is not installed !!!"
	done
}


#
# install applications
#
do_app_install()
{
	APPLIST="cvs git-core nfs-kernel-server tftpd-hpa tftp-hpa smbfs vim ssh samba \
		gitk kaffeine xine-ui vlc mplayer minicom v4l2ucp g++ filezilla codeblocks \
		wireshark gnupg flex bison gperf build-essential zip curl zlib1g-dev libc6-dev \
		x11proto-core-dev libx11-dev libgl1-mesa-dev g++-multilib mingw32 tofrodos \
		python-markdown libxml2-utils xsltproc"
	test $X64_CPU = "x86_64" && APPLIST="$APPLIST ia32-libs lib32ncurses5-dev lib32z1-dev lib32readline-gplv2-dev"

	if [ ! -z `which cvs` ] ; then
		get_answer "The CVS is installed, continue to process ?"
		if [ $g_ANS == 'n' ]; then
			exit 0
		elif [ $g_ANS == 's' ]; then
			return
		fi
	fi

	sudo apt-get -y install $APPLIST
	check_app
	cat >~.vimrc <<EOF
	syntax enable
	set smartindent
	set tabstop=4
	set shiftwidth=4
	set noexpandtab
	EOF
}


do_mnt()
{
	DIRLIST="/mnt/aver /mnt/driver /mnt/git"
	for dir in $DIRLIST; do
		if [ ! -e $dir ]; then
			sudo mkdir $dir
		else
			echo "$dir exists...skip creating directory" > /dev/null
		fi
	done
}


#
# configure samba
# in	: $1 - username
#
do_smb()
{
	SYSSMBCFG=/etc/samba/smb.conf
	SMBCFG=./tmp.conf

	if grep $G_USER $SYSSMBCFG; then
		get_answer "The $G_USER is present in smb.conf, continue to process ?"
		if [ $g_ANS == 'n' ]; then
			exit 0
		elif [ $g_ANS == 's' ]; then
			return
		fi
	fi

	if [ -f $SYSSMBCFG ]; then
		cp $SYSSMBCFG $SMBCFG
		echo "" >> $SMBCFG
		echo "[$G_USER]" >> $SMBCFG
		echo "	path = /home/$G_USER/" >> $SMBCFG
		echo "	browseable = yes" >> $SMBCFG
		echo "	read only = no" >> $SMBCFG
		echo "	guest ok = no" >> $SMBCFG
		echo "	create mask = 0664" >> $SMBCFG
		echo "	directory mask = 0755" >> $SMBCFG
		echo "	force user = $G_USER" >> $SMBCFG
		echo "	force group = $G_USER" >> $SMBCFG
		sudo mv $SMBCFG $SYSSMBCFG
	fi

	if [ ! -z `which smbpasswd` ]; then
		sudo smbpasswd -L -a $G_USER 
		sudo smbpasswd -L -e $G_USER
	fi
}

function echoCmd() {
	[ -n "$1" ] && {
		echo "$1"
		eval "$1"
	}
}

#since alias takes no parameter, use function instead
function ssh20() {
	doDel=
	NET=192.168.20
	if [ $# -lt 1 ]; then
		echo Usage: ssh20 LAST_IP [USER]
		echo "   ssh root@${NET}.LAST_IP by default"
	else
		USER=root
		[ -n "$2" -a "$2" == "-d" ] && doDel=yes
		if [ -n "${doDel}" ]; then
			# try to kill existing ssh end with $1
			curSSH=`ps aux | grep ssh | egrep "$1\$" | awk '{ print $2 }'`
			curSSHcount=`echo ${curSSH} | wc -l`
			echo "found ${curSSHcount} ssh process:"
			for line in ${curSSH}; do
				id=`echo ${line} | sed -e s/[^0-9]//g`
				echoCmd "kill -9 ${id}"
			done
		fi
		ssh-keygen -f "/home/oem/.ssh/known_hosts" -R "${NET}.$1"
		echoCmd "ssh ${USER}@${NET}.$1"
	fi
}

#NOTE:
#1.the mount.cifs uid=<uid#>, the user name becames unavailable after 11.10
#2.the ia32-libs fails x86 installation

get_param $1
do_app_install
do_mnt
do_bashrc
do_smb
