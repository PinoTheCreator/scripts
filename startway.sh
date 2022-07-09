#!/bin/bash

waybar &
wbg ~/Pictures/gruvbox_spiritedaway.jpg &
wlsunset -S 08:00 -s 20:00 -d 1800 &
dunst &
noisetorch -i &

gentoo-pipewire-launcher &
