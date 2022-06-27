#!/bin/bash

waybar &
wbg ~/Pictures/spiritedtrain.jpg &
wlsunset -L 41.50 -l 12.30 &
dunst &

pipewire &
pipewire-pulse &
pipewire-media-session &
