#!/usr/bin/bash

# Transition config (type swww img --help for more settings
FPS=30
TYPE="simple"
DURATION=3

IMG_DIR=$HOME/.local/share/wallpapers/
PICS=($(ls ${IMG_DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$"))
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

RANDOM_PIC=${PICS[ $RANDOM % ${#PICS[@]} ]}
RANDOM_PIC_NAME="${#PICS[@]}. random"

echo $RANDOM_PIC
swww img $IMG_DIR/$RANDOM_PIC $SWWW_PARAMS
