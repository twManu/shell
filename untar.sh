# Usage:
#	untar.sh -F|-R [-s SRC_FILE] -t TGT_DIR [-q]
#

#
# In	: $1- message
#
function usage()
{
	echo "Error: $1"
	echo Usage:
	echo "untar.sh -F|-R|-G [-s SRC_FILE] -t TGT_DIR [-q]"
	echo "  F : Fedora Core 3"
	echo "  R : Red Hat 9"
	echo "  G : Fedora Core 4"
	echo " SRC_FILE: if omited, $RH9/$FC3 as default for R/F"
	echo " TGT_DIR: target directory"
	echo "  q : quiet"
	exit 0
}

#
# main
#
CUR_DIR=$PWD
RH9DIR=$CUR_DIR/RH9
RH9=rh9-root.tgz
FC3DIR=$CUR_DIR/FC3
FC3=fc3-root.tgz
FC4DIR=$CUR_DIR/FC4
FC4=fc4-root.tgz
D4_SRC_FILE=
SRC_FILE=
TGT_DIR=
QUIET=			#not quiet by default

#
# 1. Check parameters
#
while getopts ":t:s:RFGBq" arg
do
	case "$arg" in
	t)	TGT_DIR=$OPTARG;;
	s)	SRC_FILE=$OPTARG;;
	F)	D4_SRC_FILE=$FC3DIR/$FC3;;
	R)	D4_SRC_FILE=$RH9DIR/$RH9;;
	G)	D4_SRC_FILE=$FC4DIR/$FC4;;
	q)	QUIET=yes;;
	esac
done

test -z $TGT_DIR &&  usage "No target directory assigned"
test ! -d $TGT_DIR && usage "Target directory $TGT_DIR doesn't exist"
test -z $D4_SRC_FILE && usage "Please use -F, -G or -R flag"
test -z $SRC_FILE && SRC_FILE=$D4_SRC_FILE

test ! -f $SRC_FILE && usage "File $SRC_FILE doesn't exist"

#
# 2. Determine source file type, what dir to create after install
#
case $D4_SRC_FILE in
*$FC3)
	#tared "bin dev etc home initrd lib media misc opt root"
	#tared "sbin selinux srv tftpboot usr var"
	DIRS="boot mnt/usb proc sys tmp"
	#not created lost+found
	;;
*$FC4)
	#tared "bin dev etc home lib media misc opt root"
	#tared "sbin selinux srv tftpboot usr var"
	DIRS="boot mnt/usb net proc sys tmp"
	#not created lost+found
	;;
*$RH9)
	#tared "bin boot dev etc home initrd lib lost+found misc mnt"
	#tared "opt proc root sbin tftpboot tmp usr var"
	DIRS="mnt/usb"
	;;
*)	usage "Unknown system";;
esac

#
# guess format
#
if echo $SRC_FILE | grep -q -e "tgz$"; then
	FLAGS="-xzf"
elif echo $SRC_FILE | grep -q -e "tar$"; then
	FLAGS="-xf"
else
	usage "Unknown source file format" 
fi

if [ -z $QUIET ]; then
	echo -n "        To untar $FLAGS \"$TGT_DIR\" from $SRC_FILE ? (y/n): "
	read ANSWER
	if [[ x$ANSWER != xy && x$ANSWER != xY ]]; then exit 0; fi
fi
echo Processing...

pushd . >/dev/null 2>&1
cd $TGT_DIR;tar $FLAGS $SRC_FILE
if [ x"$DIRS" != x ]; then
	echo Creating directories $DIRS ...
	mkdir -p $DIRS
fi
popd >/dev/null 2>&1
