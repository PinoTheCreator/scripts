#!/bin/bash

PERCENTAGE=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
STEP=5

case $1 in
	high)
		# Set the volume on (if it was muted)
		pactl set-sink-mute @DEFAULT_SINK@ 0
		[ $PERCENTAGE -gt $(expr 100 + 1 - $STEP) ] && pactl set-sink-volume @DEFAULT_SINK@ 100% || pactl set-sink-volume @DEFAULT_SINK@ +$STEP%
		;;
	low)
		# Set the volume on (if it was muted)
		pactl set-sink-mute @DEFAULT_SINK@ 0
	    pactl set-sink-volume @DEFAULT_SINK@ -$STEP%
		;;
	muted)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		;;
esac

PERCENTAGE=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

VOLUME="muted"
[ $PERCENTAGE -gt 0  ] && VOLUME="low"
[ $PERCENTAGE -gt 24 ] && VOLUME="medium"
[ $PERCENTAGE -gt 49 ] && VOLUME="high"
[ $PERCENTAGE -gt 74 ] && VOLUME="overamplified"
[ $STATUS = "yes" ] && VOLUME="muted"

dunstify -a "multimedial" -r "9993" -h int:value:"$PERCENTAGE" -i "~/Pictures/popcatpng/$VOLUME.png" "Volume $VOLUME: $PERCENTAGE%"
