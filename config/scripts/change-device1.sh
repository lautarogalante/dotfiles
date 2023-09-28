#!/bin/bash

DEVICE1="alsa_output.pci-0000_01_00.1.hdmi-stereo"
pactl set-default-sink "$DEVICE1" && pactl set-sink-volume "$DEVICE1" 90%
