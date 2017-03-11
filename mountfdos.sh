#!/bin/bash
# Usage: mountfdos FULL_PATH_IMAGE, /mnt/Data/KVM/fdos.img by default

MNT_DIR=/mnt/fdos
IMG=/mnt/Data/KVM/fdos.img

mkdir -p $MNT_DIR

test -n "$1" && IMG=$1
if [ -f $IMG ]; then
	sudo mount -t msdos -o loop,offset=32256 $IMG $MNT_DIR
else
	echo "Missing $IMG"
fi

