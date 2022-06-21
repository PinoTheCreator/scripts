#!/bin/bash

declare -a options=(".bashrc"
"dunst"
"dwl"
"foot"
"gtk-3.0"
"imv"
"lf/icons"
"lf/lfrc"
"nvim"
"oguri"
"vis"
"waybar/style.css"
"waybar/config"
)

choice=$(echo "$(printf '%s\n' "${options[@]}")" | bemenu -p 'Edit config file: ')

case $choice in
	.bashrc)
		choice="$HOME/$choice" ;;
	dwl)
		choice="$HOME/.config/$choice/config.def.h";;
	foot)
		choice="$HOME/.config/$choice/foot.ini";;
	gtk-3.0)
		choice="$HOME/.config/$choice/settings.ini";;
	imv)
		choice="$HOME/.config/$choice/config";;
	"lf/icons")
		choice="$HOME/.config/$choice";;
	"lf/lfrc")
		choice="$HOME/.config/$choice";;
	nvim)
		choice="$HOME/.config/$choice/init.vim";;
	oguri)
		choice="$HOME/.config/$choice/config";;
	vis)
		choice="$HOME/.config/$choice/visrc.lua";;
	"waybar/style.css")
		choice="$HOME/.config/$choice";;
	"waybar/config")
		choice="$HOME/.config/$choice";;
	*)
		dunstify "But nothing happened..." && exit 1;;
esac

foot $EDITOR "$choice"
