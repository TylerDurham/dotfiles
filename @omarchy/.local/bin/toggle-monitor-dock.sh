#!/bin/bash

# Get connected monitor names
CONNECTED=$(hyprctl -j monitors | jq -r '.[].name')

# Check if we're docked (DP-5 or DP-6 present)
if echo "$CONNECTED" | grep -qE 'DP-5|DP-6'; then
  echo "Dock detected: disabling laptop screen and enabling external layout"

  # Disable eDP-1
  hyprctl keyword monitor "eDP-1, disable"

  # Enable and position external monitors
  hyprctl keyword monitor "DP-6, preferred, 0x0, 1.6"
  hyprctl keyword monitor "DP-5, 2560x1080@74.99, 2560x0, 1.0"
else
  echo "Undocked: enabling laptop screen only"

  # Enable eDP-1 (auto position, scale 1.25 if it's HiDPI)
  hyprctl keyword monitor "eDP-1, preferred, 0x0, 1.25"

  # Disable external monitors (just in case)
  hyprctl keyword monitor "DP-6, disable"
  hyprctl keyword monitor "DP-5, disable"
fi
