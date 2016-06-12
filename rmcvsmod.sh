#!/bin/sh

#
# To remove modified cvs files (local)
#
# Note: make sure modified source are committed separately
#

#cvs -n update | grep "^M" | awk '{print $2}' | xargs rm
cvs -n update | grep "^?" | awk '{print $2}'
