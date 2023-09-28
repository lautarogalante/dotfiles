#!/bin/bash

# Obtener la posición actual del mouse
#eval $(xdotool getmouselocation --shell)
workspaces=$(swaymsg -t get_workspaces)
# Obtener el ancho del monitor
monitor=$(echo $workspaces | jq '.[] | select(.focused==true) | .output')

# Calcular el monitor actual
#monitor=$((X / monitor_width))

# Cambiar al espacio de trabajo correspondiente en el monitor actual
if [ $monitor == "\"$out-left\"" ]; then
    swaymsg workspace "${1}a"
else
    swaymsg workspace "${1}b"
fi
