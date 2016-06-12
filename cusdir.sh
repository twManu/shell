#!/bin/sh

CUSTROOT=/home/custom

find ${CUSTROOT} -maxdepth 2 | grep -e "-[0-9].*\.[0-9][0-9][1-9,a-c][0-9][0-9]$"

