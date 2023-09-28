#!/bin/bash
#
DEVICE2="alsa_output.pci-0000_00_14.2.analog-stereo"
pactl set-default-sink "$DEVICE2" && pactl set-sink-volume "$DEVICE2" 90%
