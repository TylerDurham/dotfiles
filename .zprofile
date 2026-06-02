
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  if $(gum confirm "Start Hyprland?"); then
    gum log --level info "Starting Hyprland..."
    start-hyprland
  fi
fi
# if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
#     exec start-hyprland
# fi
