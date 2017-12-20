#!/usr/bin/env bash
# author: Hendrik Werner s4549775

usage() {
	echo "usage: [DEBUG=1] $0 <threshold>"
}

[[ $# != 1 ]] && usage && exit 1
(( $1 < 0 )) && echo "Threshold must be >= 0" && usage && exit 2
(( $1 > 100 )) && echo "Threshold must be <= 100" && usage && exit 3

# `top -bn1` should work as well, but it does not seem to be very accurate
# `top -bn2` seems reasonable accurate

while true; do
	cpu_usage=$(top -bn2 | grep -oP "%Cpu0.*?\K\d+(?=\[)" | tail -n1)
	[[ $DEBUG ]] && echo "CPU usage: $cpu_usage%"
	echo Received: $(($cpu_usage > $1))
done
