#!/usr/bin/env bash

# Parse args and flags
while [[ $# -gt 0 ]]; do
  case "$1" in
  -r | --remove)
    REMOVE=1
    shift
    ;;
  esac
done

if [[ -n "$REMOVE" ]]; then
  warn "Not supported - yet!"
  exit 0
fi

[[ -d ~/.config/hypr ]] || exit 0

if [[ -f ~/.config/hypr/hyprland.conf ]]; then
  echo "Cleaning ~/.hypr/hyprland.conf"
  mv ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.bak
fi
