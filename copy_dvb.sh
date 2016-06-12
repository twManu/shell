#!/bin/sh

#
# output error message and usage before end process
# In	: $1- message
#
function usage()
{
	test ! -z "$1" && echo "Error: $1"
	echo "Usage: $0 SRC_KERNEL_TREE [TGT_KERNEL_TREE]"
	echo "	copy dvb-core, dvb-usb and frontends headers from SRC to TGT kernel tree"
	echo "	    SRC_KERNEL_TREE: the source of root of kernel tree"
	echo "	    TGT_KERNEL_TREE: the target of root of target tree,"
	echo "	        if missed, /lib/modules/\`uname -r\`/source is used"
	exit 1
}


COMMON_PATH=drivers/media/dvb
SUB_DIRS="$COMMON_PATH/dvb-core $COMMON_PATH/dvb-usb $COMMON_PATH/frontends"
TGT_KERNEL_ROOT=/lib/modules/`uname -r`/source

###################################
#####  check source directory #####
test $# -lt 1 && usage "Incorrect arguments"
SRC_KERNEL_ROOT=$1
test ! -d "$SRC_KERNEL_ROOT" && usage "Missing source directory"
echo "   SOURCE: $SRC_KERNEL_ROOT"

###################################
#####  check target directory #####
shift
test ! -z "$1" && set TGT_KERNEL_ROOT=$1
test ! -d "$TGT_KERNEL_ROOT" && usage "Missing target directory"
echo "   TARGET: $TGT_KERNEL_ROOT"

###########################################
##### processing each sub-directories #####
for dir in $SUB_DIRS; do
	if [ ! -d $SRC_KERNEL_ROOT/$dir ]; then
		echo "Missing source $SRC_KERNEL_ROOT/$dir ...skip"
		continue
	fi
	if [ ! -d $TGT_KERNEL_ROOT/$dir ]; then
		echo "Missing target $TGT_KERNEL_ROOT/$dir ...skip"
		continue
	fi
	echo "        copying $dir"
	cp $SRC_KERNEL_ROOT/$dir/*.h $TGT_KERNEL_ROOT/$dir
done

