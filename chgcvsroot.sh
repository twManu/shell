#!/bin/bash

#
# $1 : top directory to check CVS with
#

# change the [NEW_IP] in [FILE] 
# $1 [FILE] file name, no check FILE here
# $2 [NEW_IP] to replace manuchen@xxx:/wincvs in [FILE], no check NEW_IP here
chgIPofFile() {
	local FILE=$1
	local NEW_IP=$2

	# echo FILE=$FILE, NEW_IP=$NEW_IP
	cat $FILE | sed -e "s/[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+/$NEW_IP/" > $FILE.tmp
	mv $FILE.tmp $FILE
}

############
### main ###
############

# 1. check top directory
test ! -d "$1" && echo Please input valid dir name && exit
TOP_DIR=$1

# 2. get cvs server IP
echo -n "Please input IP of CVS server: "
read NEW_IP

# 3. check cvs server IP
if [ ! -z "$NEW_IP" ]; then
	TEST_IP=`echo $NEW_IP | grep -e "[0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+"`
	if [ -z "$TEST_IP" ]; then      
		echo "Invalid IP ($NEW_IP)"
                exit
	fi      
fi
echo Replacing new ip $NEW_IP

# 4. process replacement
find $TOP_DIR -path "*/CVS/Root" | while read f; do chgIPofFile $f $NEW_IP; done

