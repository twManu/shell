#!/bin/sh

# there are 37 channels in area of post code 95035
TMP_FILE=tmp.log
grep "SignalLocked =" scan.LOG >$TMP_FILE

cat $TMP_FILE | awk 'BEGIN { x=0 } {print "channel"x+1 $4,$5; ++x; x%=37 }'

