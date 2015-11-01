#!/bin/bash

usage_exit() {
	echo "Usage: $0 [-y|-n] [-h] -j {chef node file} -t {target dir} -l {debug|info|warn|error|fatal}" 1>&2
	echo "-y don't confirm actually run"
	echo "-n only why-run"
	echo "-h show this help"
	echo "-j {node file}"
	echo "-l {loglevel}"
	echo "-t {target directory}"
	exit 1
}

YES=0
UPDATE=0
NO=0
NODE=''
LEVEL=''
DIR=''

while getopts yuhj:l:nt: OPT
do
	case $OPT in
		y)	YES=1
			;;
		h)	usage_exit
			;;
		j)	NODE=$OPTARG
			;;
		l)	LEVEL=$OPTARG
			;;
		n)	NO=1
			;;
		t)	DIR=$OPTARG
			;;
	esac
done

if [ "$NODE" = "" ]; then
	usage_exit
fi

if [ ! "$DIR" = "" ]; then
	cd "$DIR"
fi

if [ ! -d '.chef' ]; then
	echo "directory \".chef\" is not found."
	exit 1
fi


if [ "$NODE" = "" ]; then
	exit 0
fi

if [ ! $YES = "1" ];
then
	if [ "$LEVEL" = "" ];
	then
		chef-solo -c .chef/knife.rb -j "${NODE}" --why-run
	else
		chef-solo -c .chef/knife.rb -j "${NODE}" --why-run --log_level $LEVEL
	fi
fi
if [ $NO = "1" ];then
	exit 0
fi
if [ ! $YES = "1" ];
then
	echo -n "run? (y/N): "
	read INPUT
fi
if [ "${INPUT}" = "y" -o "${INPUT}" = "Y" -o $YES = "1" ];
then
	if [ "$LEVEL" = "" ];
	then
		chef-solo -c .chef/knife.rb -j "${NODE}"
	else
		chef-solo -c .chef/knife.rb -j "${NODE}" --log_level $LEVEL
	fi
fi

