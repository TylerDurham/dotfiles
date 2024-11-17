#!/usr/bin/bash

killall waybar
pkill waybar
sleep .75

waybar -c ~/.config/waybar/config.jsonc
