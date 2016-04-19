#!/bin/sh
# check usage
TGTDIR=
#relative to kernel tree
SUBDIR=
GIT_SRC=
TGTTAG=master

IS_HTTP=

#
# Usage:
#   dirdiff -s SRC_DIR [-t TGT_DIR] [-c]  
#
# show difference of file name between SRC_DIR and TGT_DIR
# those missing in TGT_DIR can be copied from SRC_DIR if -c specified
#
usage() {
	echo "Usage: $0 -s GIT_SRC [-d DIR_NAME] [-p RELATIVE_PATH] [-t TAG]"
	echo "  ex. $0 -s https://github.com/manuTW/linux -p drivers/media -t v3.12"
	echo "    -s : use file, git://, or https:// protocal to get GIT_SRC"
	echo "    -d : checkout directory name"
	echo "    -p : relative path without \"/\" from GIT_SRC to checkout, default as all GIT_SRC"
	echo "    -t : default to master if not provided"
	exit
}



#parse and do checkout

parse_param() {
	while getopts ":s:p:t:d" opt; do
		case $opt in
		s) GIT_SRC=$OPTARG;;
		d) TGTDIR=$OPTARG;;
		p) SUBDIR=$OPTARG;;
		t) TGTTAG=$OPTARG;;
		\?) usage;;
		esac
	done

	OPTIND=1
	test -z "${GIT_SRC}" && echo Missing GIT_SRC && usage
	#remove tailing ".git" if any
	test -z "${TGTDIR}" && TGTDIR=`basename ${GIT_SRC} | sed s/\.git$//`
	IS_HTTP=`echo ${GIT_SRC}|grep -i http`
	TGTDIR=${TGTDIR}-`date +"%m%d_%H%M%S"`
	if [ -z "${SUBDIR}" ]; then
		echo Checkout ${GIT_SRC} to ${TGTDIR}, tag=${TGTTAG}
	else
		echo Checkout ${SUBDIR} of ${GIT_SRC} to ${TGTDIR}, tag=${TGTTAG}
	fi
}


parse_param $@

mkdir -p ${TGTDIR}; cd ${TGTDIR}
git init
git remote add -f origin ${GIT_SRC}
git fetch origin
git config core.sparseCheckout true
test -n "${SUBDIR}" && echo "${SUBDIR}" > .git/info/sparse-checkout
if [ ${TGTTAG} = "master" ]; then
	git checkout master
else
	git checkout -b br_${TGTTAG} ${TGTTAG}
fi


