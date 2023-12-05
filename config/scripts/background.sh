#!/bin/bash

DIR="/home/lautaro/Wallpapers"
TIME=300

while true; do
	PIC=$(find $DIR -type f | shuf -n 1)
	swaymsg output '*' bg $PIC fill
	sleep $TIME
done
