[[ -z $DISPLAY && $(tty) == /dev/tty1 ]] && exec Hyprland


if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

ssh-add -l >/dev/null || ssh-add ~/.ssh/id_ed25519
