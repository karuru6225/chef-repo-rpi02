#!/bin/bash

if [[ $1 = "" ]];then
	echo "USAGE: $0 <Base VM Name> <Box Name>"
	exit 1
fi

set -ex

vagrant package --base "$1"
vagrant box remove "$2" 
vagrant box add "$2" package.box
mv package.box "$2"
