#!/bin/bash

g_SRC_DIR=
g_TGT_DIR=.
g_ACT_COPY=0


#
# Usage:
#   dirdiff -s SRC_DIR [-t TGT_DIR] [-c]  
#
# show difference of file name between SRC_DIR and TGT_DIR
# those missing in TGT_DIR can be copied from SRC_DIR if -c specified
#
usage() {
	echo "USage: dirdiff -s SRC_DIR [-t TGT_DIR] [-c]"
	echo "    SRC_DIR: source directory"
	echo "    TGT_DIR: target directory, default as current directory"
	echo "    -c:      copy those TGT_DIR missing"
}


#
# Update g_xxx variable
#
parse_param() {
	while getopts ":s:t:c" opt; do
		case $opt in
		s) g_SRC_DIR=$OPTARG;;
		t) g_TGT_DIR=$OPTARG;;
		c) g_ACT_COPY=1;;
		\?) usage
		    exit;; 
		esac
	done
	OPTIND=1
}


#
# Check if g_xxx variable valid
# ask for confirmation if to alter something
#
check_param() {
	test -z ${g_TGT_DIR} && $g_TGT_DIR=$CWD
	test ! -d $g_SRC_DIR && echo "Error: '$g_SRC_DIR' is not a valid source directory" && exit
	#echo source dir=$g_SRC_DIR, target dir=$g_TGT_DIR, do copy=$g_ACT_COPY
	if [ 0 != $g_ACT_COPY ]; then
		echo -n "    copy missing files of $g_TGT_DIR from $g_SRC_DIR? (y/n) "
		read ans
		case $ans in
		y*|Y*) ;;
		*) echo "    ...stop processing !!!"
		   exit;;
		esac
	else
		echo "    show different file in $g_SRC_DIR and $g_TGT_DIR..."
	fi
}


#
# show those source have but target doesn't
# $1    : source directory
# S2    : target directory
# $3    : prefix char (- or +)
process_1() {
	local dir_list=
	local count=0
	local src
	local tgt
	local prefix

	if [ $# -lt 3 ]; then
		echo wrong argument number !!!
		exit
	else
		src=$1; tgt=$2; prefix=$3
	fi

	for file in `ls -a $src`; do
		((count++))
		if [ -f $src/$file ]; then
			test ! -f $tgt/$file && echo "${prefix}f $src/$file"
		elif [ -d $src/$file ]; then
			test ! -d $tgt/$file && echo "${prefix}d $src/$file"
			if [ $count -gt 2 ]; then	#skip . ..
				if [ "$dir_list" == "" ]; then
					dir_list=$file	#avoid " abc", "abc" instead
				else
					dir_list="$dir_list $file"
				fi
			fi
		else
			test ! -e $tgt/$file && echo "${prefix} $src/$file"
		fi
	done

	test ! -z "$dir_list" && echo "directory '${dir_list}' not compared !"
}


#
# show source has but target doesn't with + and - vice versa
# $1    : source directory
# S2    : target directory
#
process() {
	local src
	local tgt

	test $# -lt 2 && echo wrong argument number !!! && exit
	src=$1; tgt=$2

	process_1 $src $tgt "-"
	process_1 $tgt $src "+"
	
}



############
### main ###
############
parse_param $@
check_param
process $g_TGT_DIR $g_SRC_DIR

