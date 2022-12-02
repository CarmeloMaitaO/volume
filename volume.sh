#!/bin/sh

optstring="rlm"
while getopts ${optstring} arg; do
        case ${arg} in
                r)
                        cmd="set-sink-volume"
			volume="+5%"
                        ;;
                l)
                        cmd="set-sink-volume"
			volume="-5%"
                        ;;
		m)
			cmd="set-sink-mute"
			volume="toggle"
			;;
                ?)
                        echo "Invalid option: -${OPTARG}."
                        exit 2
                        ;;
                *)
                        echo "Invalid usage"
                        exit 2
                        ;;
        esac
done

for SINK in `pacmd list-sinks | grep 'index:' | cut -b12-`
do
  pactl $cmd $SINK $volume
done
volume="$(pactl get-sink-volume $(pactl get-default-sink) | 
	awk -F '/' '{print $2}')"
mute="$(pactl get-sink-mute $(pactl get-default-sink))"
feedback="$(echo -e "$volume \n $mute")"
dunstify -r 23919 -u 0 "$feedback"
