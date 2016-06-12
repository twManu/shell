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

cpp -fpreprocessed $1 >$1.pre
diff $1 $1.pre >$1.diff
cat $1.diff | grep -e '<[ tab]*#[ tab]*define' | grep -v -e '//' |\
sed 's/^<[ tab]*#[ tab]*define/#define/g' >$1.define
