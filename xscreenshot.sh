#!/bin/bash

MENU="dmenu"

OPTIONS=$(echo -e "-Crop\n-Fullscreen" | $MENU -p "Screenshot:")

case $OPTIONS in
	"-Crop") TOKEN=1;;
	"-Fullscreen") TOKEN=0;;
	*)
		dunstify "Invalid entry!"
		exit 1 
		;;
esac

SAVE=$(echo -e "-Clipboard\n-Save" | $MENU)

case $SAVE in
	"-Save")
		SAVEPATH=~/Pictures/Screenshots
		SAVENAME=$(date "+%Y%m%d-%H%M%S").png

		[ $TOKEN -eq 0 ] && maim $SAVEPATH/$SAVENAME
		[ $TOKEN -eq 1 ] && maim -s $SAVEPATH/$SAVENAME

		CHANGE=$(echo -e "No\nYes" | $MENU -p "Change image's name?")
		[ $CHANGE = "Yes" ] && NEW=$(echo -e "" | $MENU -p "New name:")

		if [ $NEW ]
		then
			COUNT=$(ls $SAVEPATH | grep $NEW | wc -l)
			[ $COUNT -gt 0 ] && NEW+=($COUNT).png || NEW+=.png
			mv $SAVEPATH/$SAVENAME $SAVEPATH/$NEW && SAVENAME=$NEW
		fi

		dunstify "$SAVENAME saved in $SAVEPATH"
		;;
	"-Clipboard")
		[ $TOKEN -eq 0 ] && maim | xclip -selection clipboard -t image/png
		[ $TOKEN -eq 1 ] && maim -s | xclip -selection clipboard -t image/png

		dunstify "Screenshot saved in the clipboard!"
		;;
	*)
		dunstify "Invalid entry!"
		exit 1 
		;;
esac
