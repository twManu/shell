#!/bin/sh
#
# To touch the whole directory
#
# In	: $1 - target directory
#

# In	: $1 - given string to show
#
usage()
{
	echo "$1"
	echo "Usage: touchd.sh TARGET_DIR"
	exit -1
}

test -z $1 && usage
test ! -d $1 && usage "\"$1\" does not exist !!!"

find $1 -exec touch '{}' \;
