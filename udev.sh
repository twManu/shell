#!/bin/bash
echo "udevadm info --query=all --name=usb"
echo "udevadm info --query=all --name=/dev/dri/card0 --attribute-walk"
echo "udevadm info --attribute-walk --path=$(udevadm info --query=path --name=/dev/dri/card0)"
echo "udevadm monitor"
echo "sudo udevadm control --reload"
echo "tail -f /var/log/usbdevice.log"
