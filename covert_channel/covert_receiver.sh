#!/usr/bin/env bash
# author: Hendrik Werner s4549775

usage() {
	echo "usage: [DEBUG=1] $0 <threshold>"
}

[[ $# != 1 ]] && usage && exit 1
(( $1 < 0 )) && echo 'Threshold must be >= 0' && usage && exit 2

while true; do
	task_time=$((time ./cpu_intensive_task.sh) 2>&1 | grep -oP '^real\s+[\d.]+m\K[\d.]+(?=s$)' | tr -d . | sed -r s/^0+//)
	[[ $DEBUG ]] && echo "Task time: $task_time"
	echo Received: $(($task_time > $1))
done
