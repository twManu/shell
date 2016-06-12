#!/bin/bash
# dump given size from memory to current dir
# $1 dump size, must >= 4096, and round down to 4K
#    can be number of xxxK, xxxM, xxxG
#
# dump2file FILE or
#	if FILE present, it must contain "USB=[PATH]/[FNAME]"
#	or "HD=[PATH]/[FNAME]" or "NFS=[PATH]/[FNAME]"
#
# dump2file SIZE or
# dump2file SIZE INPUT_FILE or
# dump2file SIZE INPUT_FILE OUTPUT_FILE
# 
# INUPT_FILE defaults to /dev/zero
# OUTPUT_FILE defaults to dmp2file_SIZE


file_path=`dirname $0`
. $file_path/func

#
#parameter check
#

test -z $1 && echo Error paramter && exit
test -f $1 && doFile $1 && exit

#get size
fsize=`expr 1024 \* 1024 \* 1024`
usrSize=$1
case $usrSize in
*G|*g)
	usrSize=`echo $usrSize |sed -e s/[Gg]//`
	fsize=`expr $usrSize \* $SIZE_1G`
	;;
*M|*m)
	usrSize=`echo $usrSize |sed -e s/[Mm]//`
	fsize=`expr $usrSize \* $SIZE_1M`
	;;
*K|*k)
	usrSize=`echo $usrSize |sed -e s/[Kk]//`
	fsize=`expr $usrSize \* $SIZE_1K`
	;;
*)
	fsize=$usrSize
	;;
esac


#get file name
inFile=/dev/zero
test ! -z $2 && inFile=$2
outFile=$3

checkSize $fsize

test -z $outFile && outFile=dmp2file_$DISPLAY_SIZE
test ! -c $outFile && rm -f $outFile

echo "Dump from $inFile to $outFile, size=$DUMP_SIZE"
doDump $inFile $outFile $BLOCK_SIZE $COUNT

