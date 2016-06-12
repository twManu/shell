# Usage:
#	tar.sh FC3|RH9|FC4 TGT_FILE SRC_DIR
#

#
# In	: $1- message
#
function usage()
{
	echo "Error: $1"
	echo Usage:
	echo "$0 FC3|RH9|FC4 TGT_FILE SRC_DIR"
	exit 0
}

#
# check parameters
#
if [ "$#" != "3" ]; then usage "parameter count"; fi

if [ -d $3 ]; then SRC_DIR=$3; else usage "Directory doesn't exist"; fi

if [ ! -f $2 ]; then TGT_FILE=$2; else usage "File exist"; fi
 
case $1 in
FC3)
	echo "  **** you MUST boot with FC3 and then tar from / !!! ****"
	DIR1="bin dev etc home initrd lib media misc opt root"
	DIR2="sbin selinux srv tftpboot usr var"
	# yet tared : boot lost+found mnt proc sys tmp
	;;
FC4)
	echo "  **** you MUST boot with FC4 and then tar from / !!! ****"
	DIR1="bin dev etc home lib media misc opt root"
	DIR2="sbin selinux srv tftpboot usr var"
	# yet tared : boot lost+found mnt net proc sys tmp
	;;
RH9)
	echo "  **** you SHOULDN'T boot with RH9 and then tar from / !!! ****"
	DIR1="bin boot dev etc home initrd lib lost+found misc mnt"
	DIR2="opt proc root sbin tftpboot tmp usr var"
	;;
*)
	usage "Unknown system"
	;;
esac

#
# guess target file
#
if echo $TGT_FILE | grep -q -v -e "^\/" ; then
	TGT_FILE=`pwd`/$TGT_FILE
fi

#
# guess format
#
if echo $TGT_FILE | grep -q -e "tar$"; then
	FLAGS="-c -p --same-owner -l -f"
	ZIP=0
elif echo $TGT_FILE | grep -q -e "tgz$"; then
	FLAGS="-c -p --same-owner -l -f -"
	ZIP=1
else
	usage "Unknown target file format" 
fi

echo "        To tar $FLAGS"
echo "            $DIR1"
echo "            $DIR2"
echo -n "        from \"$SRC_DIR\" as $TGT_FILE ? (y/n): "

read ANSWER
if [[ x$ANSWER != xy && x$ANSWER != xY ]]; then exit 0; fi

echo Processing...

if [ -z "$ZIP" ]; then
	cd $SRC_DIR;tar $FLAGS $TGT_FILE $DIR1 $DIR2
else
	cd $SRC_DIR;tar $FLAGS $DIR1 $DIR2 | gzip -1 >$TGT_FILE
fi

