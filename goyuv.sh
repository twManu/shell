#!/bin/bash

D4_MAX_PACKET=3045
D4_P_NAME="VP2730 UVC Device"
VID=1367
PID=10244
VENDOR_NAME="ATEN International Co.,Ltd"
CMD_PREFIX=

P_NAME=
MAX_PACKET=

#
# Usage:
#   gouvc [-p PRODUCT_NAME] [-x MAX_PACKET]  
#
#
usage() {
	echo "Usage: $0 [-p PRODUCT_NAME] [-x MAX_PACKET]"
	echo "    PRODUCT_NAME: product name, default to ${D4_P_NAME}"
	echo "    MAX_PACKET: max packet, yuv defaults to ${D4_MAX_PACKET}"
}


#
# Update g_xxx variable
#
parse_param() {

	while getopts ":p:x:" opt; do
		case $opt in
		p) P_NAME=$OPTARG;;
		x) MAX_PACKET=$OPTARG;;
                \?) usage
                    exit;;
                esac
	done
	OPTIND=1

	test -z "${P_NAME}" && P_NAME=${D4_P_NAME}
	test -z ${MAX_PACKET} && MAX_PACKET=${D4_MAX_PACKET}
	test 0 -eq `id|grep root|wc -l` && CMD_PREFIX="sudo "
	#echo "command=$CMD_PREFIX, $P_NAME, $MAX_PACKET"
}


#
# Remove driver
#
rmdriver() {
	${CMD_PREFIX}rmmod g_webcam >/dev/null 2>&1
	s{CMD_PREFIX}rmmod usb_f_uvc >/dev/null 2>&1
}


#
# Remove driver
#
lddriver(){
	${CMD_PREFIX}modprobe g_webcam idVendor=${VID} idProduct=${PID}\
		iSerialNumber="28032" iManufacturer=\"${VENDOR_NAME}\"\
		iProduct=\"${P_NAME}\" streaming_maxpacket=${MAX_PACKET}
}


########
# main
########
parse_param "$@"
rmdriver
lddriver
sleep 1
./uvc-gadget -d -u/dev/video0

