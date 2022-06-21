#!/bin/bash

case $1 in
	inc)
		MODE="-A"
		;;
	dec)
		MODE="-U"
		;;
	*)
		exit 1
		;;
esac

doas brillo -q $MODE 5

PERCENTAGE=$(brillo)

dunstify -a "multimedial" -r "10000" -h int:value:$PERCENTAGE -i "dialog-information" "Brightness: $PERCENTAGE%"
