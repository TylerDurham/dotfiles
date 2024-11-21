#!/usr/bin/bash

IMG_DIR=$HOME/.local/share/wallpapers/

# Transition config (type swww img --help for more settings
FPS=30
DURATION=3

# Random effect
TRAN_TYPES=("grow" "fade" "simple" "wave" "wipe" "left" "right")
TYPE=${TRAN_TYPES[ $RANDOM % ${#TRAN_TYPES[@]} ]} #${TRAN_TYPES[1]} #
echo $TYPE

# Swww params
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Grab a random wallpaper image
PICS=($(ls ${IMG_DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$" -e ".gif$"))
RANDOM_PIC=${PICS[ $RANDOM % ${#PICS[@]} ]}

# Get the extension
EXT="${RANDOM_PIC##*.}"

# Copy to wallpaper dir, renaming it to "current"
# Slip the extension in in case we need it later
NEW_FILE_NAME=$IMG_DIR.current.bak
NEW_FILE_NAME="${NEW_FILE_NAME/.bak/".$EXT.bak"}"
cp $IMG_DIR$RANDOM_PIC $NEW_FILE_NAME

swww img $NEW_FILE_NAME $SWWW_PARAMS
