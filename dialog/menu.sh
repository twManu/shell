#!/bin/bash

OK=0
CANCEL=1
ESC=255
BACKTITLE="Cody Blog - Example"

Menu(){
    while :
    do {
        Selection=$(dialog --title "CodyBlog - Menu" --clear \
            --backtitle "$BACKTITLE" \
            --cancel-label "Exit" \
            --menu "Choose one" 12 45 5 \
            one "Test 01" \
            two "Test 02" \
            2>&1 > /dev/tty)

        result=$?
        if [ $result -eq $OK ]; then
            Exit "$Selection selected !"
        elif [ $result -eq $CANCEL ] || [ $result -eq $ESC ]; then
            Exit
        fi
    } done
}


Exit(){
    clear
	if [ -z "$1" ]; then
    	echo "Program Terminated."
	else
		echo $1
	fi
    exit
}

Menu
