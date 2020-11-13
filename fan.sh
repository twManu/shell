#!/bin/bash

SPEED=100
test $# -ne 0 && SPEED=$1
echo Writing fan speed $SPEED
su -c "echo $SPEED >/sys/devices/pwm-fan/target_pwm"
