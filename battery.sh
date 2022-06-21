#!/bin/bash

PERC=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

BAT=" $PERC" && [ $PERC -gt 90 ] && [ $STATUS = "Charging" ] && dunstify "Battery charged!"
[ $PERC -lt 90 ] && BAT=" $PERC"
[ $PERC -lt 60 ] && BAT=" $PERC"
[ $PERC -lt 40 ] && BAT=" $PERC"
[ $PERC -lt 15 ] && BAT=" $PERC" && [ $STATUS = "Discharging" ] && dunstify -u critical "Battery low!"

[ $STATUS = "Charging" ] && BAT=" $BAT"

echo "$BAT%"

###
