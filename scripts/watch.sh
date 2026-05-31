#!/usr/bin/env bash
#
# watch.sh — Hot-reload waybar by watching config files for changes.
#
# Usage:
#   ./scripts/watch.sh
#
# Monitors ~/.config/waybar with inotifywait and sends SIGUSR2 to the running
# waybar process whenever a file is saved. This triggers waybar's built-in
# config reload without a full restart, so changes appear instantly.
#
# Vim swap files (*.swp, *.swx, numeric temps) are ignored to prevent
# spurious reloads mid-edit. Requires inotify-tools to be installed.

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Source our "dev" envs
source "$(git rev-parse --show-toplevel)/install.d/envs.sh"

# Libs
if ! . "$USER_LIB_DIR/bash/require.sh" logger; then
    echo "Could not load libraries from '$USER_LIB_DIR'!" >&2
    exit 1
fi

# Where is this file located at?
CWD=$(dirname $(realpath $0))

clear

# TODO: Make this input args???
WATCH_PATHS=(
  ~/.config/waybar
)

msg=$(cat << EOF

 ██╗    ██╗ █████╗ ████████╗ ██████╗██╗  ██╗
 ██║    ██║██╔══██╗╚══██╔══╝██╔════╝██║  ██║
 ██║ █╗ ██║███████║   ██║   ██║     ███████║
 ██║███╗██║██╔══██║   ██║   ██║     ██╔══██║
 ╚███╔███╔╝██║  ██║   ██║   ╚██████╗██║  ██║
  ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝

Watching ${#WATCH_PATHS[@]} paths...

$(for path in ${WATCH_PATHS[@]}; do 
    echo " - $(green $path)"
  done)

Press $(bold_blue "CTRL + C") to exit...

EOF
)

echo "$msg"

inotifywait -e close_write -m "${WATCH_PATHS[@]}" --format '%w %f %e' | 
while read dir file event; do

  # Ignore vim's temp swap/backup files
  [[ "$file" =~ ^[0-9]+$ || "$file" == *.swp || "$file" == *.swx ]] && continue

  echo "Recieved '$event' from directory '$dir/$file'!"

  name=$(basename $dir)

  if [[ "$name" == waybar ]]; then
    killall -SIGUSR2 waybar
    echo "'waybar' restarted!"
  fi
done
