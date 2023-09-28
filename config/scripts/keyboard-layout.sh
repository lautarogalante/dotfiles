#!/bin/bash
current=$(setxkbmap -query | awk '/layout/{print $2}')
if [ "$current" = "es" ]; then
  setxkbmap us
else
  setxkbmap es
fi
