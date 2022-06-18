#!/bin/bash

PERCENTAGE=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

case $1 in
high)
	# Set the volume on (if it was muted)
	pactl set-sink-mute @DEFAULT_SINK@ 0
	[ $PERCENTAGE -lt 100 ] && pactl set-sink-volume @DEFAULT_SINK@ +5%
	;;
low)
	pactl set-sink-mute @DEFAULT_SINK@ 0
	pactl set-sink-volume @DEFAULT_SINK@ -5%
	;;
muted)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	;;
esac

PERCENTAGE=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

VOLUME="muted"
[ $PERCENTAGE -gt 0  ] && VOLUME="low"
[ $PERCENTAGE -gt 30 ] && VOLUME="medium"
[ $PERCENTAGE -gt 65 ] && VOLUME="high"
[ $STATUS = "yes" ] && VOLUME="muted"
  
dunstify -a "multimedial" -r "9993" -h int:value:"$PERCENTAGE" -i "audio-volume-$VOLUME" "Volume $VOLUME: $PERCENTAGE%"
