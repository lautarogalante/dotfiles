#!/bin/bash

# Define los nombres de los dispositivos
echo "Ejecutando el Script" > /tmp/prueba.txt
DEVICE1="alsa_output.pci-0000_00_14.2.analog-stereo"
DEVICE2="alsa_output.pci-0000_01_00.1.hdmi-stereo"

#Definir el volumen para cada dispositivo
#VOLUME_CHANGE_DEVICE1="+5%"
#VOLUME_CHANGE_DEVICE2="+9%"
# Define el archivo de estado
STATE_FILE="/tmp/volume_device_state"

# Crea el archivo de estado si no existe
if [ ! -f $STATE_FILE ]; then
    echo $DEVICE1 > $STATE_FILE
fi

# Lee el estado actual del archivo de estado
CURRENT_DEVICE=$(cat $STATE_FILE)


# Alterna entre los dispositivos y guarda el nuevo estado en el archivo de estado
if [ "$CURRENT_DEVICE" == "$DEVICE1" ]; then
  pactl set-sink-volume "$DEVICE2" +10%
  echo $DEVICE2 > $STATE_FILE
else
  pactl set-sink-volume "$DEVICE1" +10%
  echo $DEVICE1 > $STATE_FILE
fi
