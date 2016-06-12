#!/bin/sh

#
# In	: $1- message
#
function usage()
{
	test ! -z "$1" && echo "Error: $1"
	echo "    Usage: $0 FILE"
	echo "    To remove comments in FILE"
	exit 0
}

#
# main
#

# check parameter count & file existence
#
test $# != 1 &&	usage "Incorrect number of parameter !!!"
test ! -f $1 && usage "$1 doesn't exist !!!"

# remove line comment
#
cat $1 | sed 's/\/\/.*$//g' >$1.line

# remove block comment in a line
#
cat $1.line | sed 's/\/\*.*\*\///g' >$1.block1

# remove block comment in multiple lines
#
cat $1.block1 | sed 's/\/\*\(.*^\)\+.*\*\///g' >$1.block2
