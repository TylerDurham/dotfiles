#!/usr/bin/bash

declare -a modules=("waybar" "hyprland" "blueman" "wallpaper")
IFS=$'\n' modules=($(sort <<<"${modules[*]}"))
unset IFS

restart() {
  echo "Attempting to restart module: $1"

  case $1 in
    wallpaper)
      ~/.config/waybar/scripts/wallpaper.sh
      ;;

    waybar)
      killall -SIGUSR2 waybar
      ;;

    *)
      echo "Module not recognized: $1"
      ;;
  esac
}

# If an argument was passed in, try to restart it.
if [[ $1 ]]; then
  restart $1
  exit 0
fi

# Split array with newline
menu=$(printf "%s\n" "${modules[@]}")
# Get a module from the menu
module=$(echo "$menu" | wofi -p "Select a module to restart:" --show dmenu --dmenu)

# Restart
restart $module


