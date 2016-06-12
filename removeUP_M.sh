#!/bin/bash
# remove ^M in given file

#
# Usage:
#   removeUP_M.sh [-h] [-f FILE] -n
#
usage() {
	echo "Usage: removeUP_M.sh [-h] [-n] -f FILE"
	echo "    -n: replace ^M with '\n'"
	echo "  FILE: input file to work with"
}

g_newline=0
g_file=


#
# Update g_xxx variable
#
parse_param() {
	while getopts ":nf:" opt; do
		case $opt in
		n) g_newline=1;;
		f) g_file=$OPTARG;;
		\?) usage
		    exit;;
		esac
	done
	OPTIND=1
	#echo "g_newline = $g_newline"
}

#
# validate parameter
#
check_param() {
	test -z "$g_file" && usage && exit 1
	if [[ ! -f $g_file ]]; then
		echo "Not being able to process $g_file"
		exit 1
	fi
}


#
# process file replacement
#
do_action() {
	#cat cx231xx-audio.c | sed "s/\x0d/\\n/g" >cx231xx-audio1.c
	local tmp_file=/tmp/tmpfile_removeUP_M
	local process=0
	echo "     ### first few lines of $g_file follows ###"
	cat $g_file > $tmp_file
	head -n 7 $tmp_file
	echo
	echo -n "To process $g_file "
	test $g_newline -eq 1 && echo -n "w/ new-line replacement "
	echo -n "(y/n) ? "
	read ans

	case $ans in
	y*|Y*)  process=1;;
	*)  echo "...stop processing";;
	esac

	test $process -eq 0 && exit 1
	mv $g_file $g_file.bak
	if [[ $g_newline -eq 1 ]]; then
		cat $g_file.bak | sed "s/\x0d/\\n/g" > $g_file
	else
		cat $g_file.bak | sed "s/\x0d//g" > $g_file
	fi
}

############
### main ###
############
parse_param $@
check_param
do_action
