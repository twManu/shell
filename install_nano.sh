#!/bin/bash
# Usage: new_install manuchen

IP_KVM=62.11.20.106
IP_NAS=62.11.20.100
IP_PC=62.11.20.99
IP_SERVER=62.11.20.98
PATH_GITHUB=~/work/gh
PATH_NAS=~/nas
PATH_SHELL=${PATH_GITHUB}/shell
URL_GIT_SHELL="https://github.com/twManu/shell.git"

APPLIST="gitk vim cifs-utils minicom v4l-utils terminator fcitx-libs-dev fcitx-table fcitx-tools gcin gcin-tables"
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
	result=`grep smbnas ~/.bashrc`
	if [ -n "${result}" ]; then
		get_answer "The bashrc might be updated, continue to process ?"
		if [ $g_ANS == 'n' ]; then
			exit 0
		elif [ $g_ANS == 's' ]; then
			return
		fi
	fi
	mkdir -p ${PATH_NAS} ${PATH_GITHUB}
	echo "alias smbnas='sudo mount.cifs //${IP_NAS}/share/git ~/nas -o uid=\$(id -u),gid=\$(id -g),username=manu,vers=1.0'" >>~/.bashrc
	echo "export PATH=${PATH_SHELL}:\${PATH}" >>~/.bashrc
	test ! -d ${PATH_SHELL} && cd ${PATH_GITHUB}; git clone ${URL_GIT_SHELL}
}



#
# install applications
#
do_app_install()
{
	APPLIST="gitk vim cifs-utils minicom v4l-utils terminator virtualenv virtualenvwrapper python3.8 python3.8-dev python3.8-venv apt-utils libhdf5-dev libffi-dev libxml2-dev libxslt1-dev"
	#for dayi-ibus
	APPLIST="${APPLIST} uuid-runtime"
	test $X64_CPU = "x86_64" && APPLIST="$APPLIST ia32-libs lib32ncurses5-dev lib32z1-dev lib32readline-gplv2-dev"

	get_answer "Proceed to install $APPLIST ?"
	if [ $g_ANS == 'n' ]; then
		exit 0
	elif [ $g_ANS == 's' ]; then
		return
	fi

	sudo apt update
	sudo apt install -y $APPLIST

	sudo snap install barrier
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

#NOTE:
#1.the mount.cifs uid=<uid#>, the user name becames unavailable after 11.10
#2.the ia32-libs fails x86 installation

get_param $1
do_app_install
do_bashrc
