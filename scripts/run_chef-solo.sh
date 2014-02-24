#!/bin/bash

if [[ $1 = "" ]];then
	echo "USAGE: $0 <Config File Name>"
	exit 1
fi

chef-solo -c solo.rb -j "$1"
