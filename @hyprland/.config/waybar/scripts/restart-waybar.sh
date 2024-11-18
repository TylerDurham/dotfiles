#!/usr/bin/bash

echo $1

if [[ $1 == "--restart" ]]; then

  if [[ -n $(pgrep -x waybar) ]];
    then
      echo "Terminating waybar..."
      killall waybar
  fi
  
  sleep .75

  echo "Starting waybar..."
  waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
  
  exit 0

fi

printf '{ "tooltip": "Restart waybar", "text": "" }'

