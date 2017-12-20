#!/usr/bin/env bash
# author: Hendrik Werner s4549775

usage() {
	echo "usage: $0 <threshold>"
}

[[ $# != 1 ]] && usage && exit 1

# `top -bn1` should work as well, but it does not seems to be very accurate
# `top -bn2` seems reasonable accurate

while true; do
	echo Received: $(($(top -bn2 | grep -oP "%Cpu0.*\K\d+(?=\[)" | tail -n1) > $1))
done
