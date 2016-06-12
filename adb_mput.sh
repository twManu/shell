#!/bin/bash
# put all files in a directory in host to a directory of adb device

#
# Usage:
#   adb_mput.sh LOCAL_DIR REMOTE_DIR
#   adb mput.sh FLIST REMOTE_DIR
#           FLIST - file contains a list of files
#
usage() {
	echo "Usage: adb_mput.sh LOCAL_DIR REMOTE_DIR"
	echo "       adb mput.sh FLIST REMOTE_DIR"
	echo "           FLIST - file contains a list of files"
}



############
### main ###
############
test $# -ne 2 && usage && exit
FLIST=
if [ -d "$1" ]; then
	FLIST=/tmp/flist_mput.txt
	ls $1 > $FLIST
else
	test ! -f "$1" && usage && exit
	FLIST=$1
fi
RDIR=$2

#awk '{system("adb push "$0 " /sdcard/Movies")}' $FLIST
for f in `cat $FLIST`; do
	adb push $f $RDIR
done
