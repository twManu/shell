#!/bin/bash

echo "\$0=$0"
echo "\$ZSH_NAME=$ZSH_NAME"
echo "\$BASH_SOURCE=$BASH_SOURCE"
echo "\$PWD=$PWD"
echo ""

echo "Current directory is $PWD"
tmpDir=`readlink -f $PWD`
parentDir=`dirname $tmpDir`
pushd .. >/dev/null
echo "Parent directory is $PWD"
popd >/dev/null

tmpDir=`readlink -f $BASH_SOURCE`
parentDir=`dirname $tmpDir`
echo "Script directory is $parentDir"
