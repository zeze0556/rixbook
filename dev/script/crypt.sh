#!/bin/bash

KEYFILE=""
HEADFILE=""
KEYFILEOFFSET=0
DEVICE=""
S_POS=0
PAYLOAD=0
ACTION=""
CIPHER="serpent-xts-plain64"
CRYPTSETUP="cryptsetup"
EXTEND=""
BLOCKSIZE=4194304
N=1

function convert() {
local ret=`echo $1 | awk '/[0-9]$/{print $1;next};/[gG]$/{printf "%u\n", $1*(1024*1024*1024);next};/[mM]$/{printf "%u\n", $1*(1024*1024);next};/[kK]$/{printf "%u\n", $1*1024;next}' `
echo "$ret"
}

function get_args() {
	while getopts "k:h:d:p:s:c:eb:n:m:" arg
		do 
			case $arg in
				k)
				KEYFILE=$OPTARG
				;;
		h)
			HEADFILE=$OPTARG
			;;
		d)
			DEVICE=$OPTARG
			;;
		p)
			PAYLOAD=$(($(convert $OPTARG) / 512))
			;;
		s)
			S_POS=$(convert $OPTARG)
			;;
		c)
			CIPHER=$OPTARG
			;;
		e)
			EXTEND="extend"
			;;
		b)
			BLOCKSIZE=$(convert $OPTARG)
			;;
		n)
			N=$OPTARG
			;;
		?)
			echo "unknow argument"
			exit 1
			;;
		esac
			done
}


function open() {
	$CRYPTSETUP open --keyfile-size $KEYSIZE  --key-file $KEYFILE --keyfile-offset $KEYOFFSET --header $HEADFILE $DEVICE `basename $DEVICE`
}

function close() {
	$CRYPTSETUP close `basename $DEVICE`
}

function format() {
	$CRYPTSETUP luksFormat --cipher $CIPHER --key-size 512 --keyfile-size $KEYSIZE --hash sha512  --key-file $KEYFILE --keyfile-offset $KEYOFFSET --header $HEADFILE --align-payload $PAYLOAD $DEVICE
}

function dump() {
    $CRYPTSETUP luksDump --keyfile-size $KEYSIZE  --key-file $KEYFILE --keyfile-offset $KEYOFFSET $HEADFILE
}

function extend() {
	dd if=$KEYFILE of=/dev/shm/`basename $KEYFILE` bs=$BLOCKSIZE count=1 skip=1
		HEADFILE=/dev/shm/`basename $KEYFILE`
}

function quit() {
return 0
}

function extendquit() {
rm -rf /dev/shm/`basename $KEYFILE`
}


ACTION=$1
shift
get_args $@
$EXTEND
echo $KEYFILE
echo $HEADFILE
KEYOFFSET=$((`od $KEYFILE -N $N -tu4 -j $S_POS | grep [^0$N] | awk '{print $2}'` * 8))
KEYSIZE=$((BLOCKSIZE - KEYOFFSET))

$ACTION
${EXTEND}quit


