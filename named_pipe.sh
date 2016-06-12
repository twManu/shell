#!/bin/bash
# demonstrate usage of named pipe

#
# Usage:
#   named_pipe [-s|-c] [-m MSG]
#
usage() {
	echo "USage: named_pipe [-s|-c] [-m MSG]"
	echo "    -s: run as a server"
	echo "    -c: run as a client"
	echo "   MSG: client message to display in server side"
	echo "        quit mean to stop server"
}


pipe=/tmp/testpipe
g_server=0
g_msg=


#
# Update g_xxx variable
#
parse_param() {
	while getopts ":scm:" opt; do
		case $opt in
		s) g_server=1;;
		c) g_server=0;;
		m) g_msg=$OPTARG;;
		\?) usage
		    exit;;
		esac
	done
	OPTIND=1
	echo "g_server = $g_server, g_msg = $g_msg"
}


#
# server code: read from pipe
#
do_server() {
	test ! -p $pipe && mkfifo $pipe
	trap "rm -f $pipe" EXIT
	while true; do
		if read line <$pipe; then
			if [[ "$line" == 'quit' ]]; then
				break
			fi
			echo $line
		fi
	done
	echo "Reader exiting"
}


#
# client code: write to pipe
#
do_client() {
	if [[ ! -p $pipe ]]; then
		echo "Reader not running"
		exit 1
	fi

	if [[ ! -z "$g_msg" ]]; then
		echo $g_msg >$pipe
	else
		echo "Hello from $$" >$pipe
	fi
}


############
### main ###
############
parse_param $@
if [[ $g_server -eq 1 ]]; then
	do_server
else
	do_client
fi
