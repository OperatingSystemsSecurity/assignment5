#!/usr/bin/env bash
# author: Hendrik Werner s4549775

usage() {
	echo "usage: [DEBUG=1] $0 <threshold>"
}

[[ $# != 1 ]] && usage && exit 1
(( $1 < 0 )) && echo 'Threshold must be >= ' && usage && exit 2

while true; do
	task_time=$((time ./cpu_intensive_task.sh) 2>&1 | grep -oP '^real\s+[\d.]+m\K[\d.]+s$')
	task_time_milliseconds=$(($(grep -oP '\d+(?=\.)' <<< $task_time) * 1000 + $(grep -oP '\.0*\K\d+' <<< $task_time)))
	[[ $DEBUG ]] && echo "Task time: $task_time_milliseconds"
	echo Received: $(($task_time_milliseconds > $1))
done
