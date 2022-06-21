#!/bin/bash

# add this to work directly on alsa card (not with pipewire)
DEFCARD="-c 1"

case $1 in
	high)
		# Set the volume on (if it was muted)
		amixer -q $DEFCARD sset Master unmute
		amixer -q $DEFCARD sset Master 5%+
		;;
	low)
		# Set the volume on (if it was muted)
		amixer -q $DEFCARD sset Master unmute
		amixer -q $DEFCARD sset Master 5%-
		;;
	muted)
		amixer -q $DEFCARD sset Master toggle
		;;
esac

PERCENTAGE=$(amixer $DEFCARD get Master | grep Mono: | awk '{print $4}' | cut -c 2- | head -c -3)
STATUS=$(amixer get $DEFCARD Master | grep Mono: | awk '{print $6}')

VOLUME="muted"
[ $PERCENTAGE -gt 0  ] && VOLUME="low"
[ $PERCENTAGE -gt 24 ] && VOLUME="medium"
[ $PERCENTAGE -gt 49 ] && VOLUME="high"
[ $PERCENTAGE -gt 74 ] && VOLUME="overamplified"
[ $STATUS = "[off]" ] && VOLUME="muted"

dunstify -a "multimedial" -r "9993" -h int:value:"$PERCENTAGE" -i "~/Pictures/popcatpng/$VOLUME.png" "Volume $VOLUME: $PERCENTAGE%"
