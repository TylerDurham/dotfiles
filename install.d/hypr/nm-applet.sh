#!/usr/bin/env bash

#!/usr/bin/env bash

source "$(git rev-parse --show-toplevel)/install.d/envs.sh"

# Libs
if ! . "$USER_LIB_DIR/bash/require.sh" logger; then
  echo "Could not load libraries from '$USER_LIB_DIR'!" >&2
  exit 1
fi

# Where is this file located at?
CWD=$(dirname $(realpath $0))

while [[ $# -gt 0 ]]; do
  case "$1" in
  -r | --remove)
    REMOVE=1
    shift
    ;;
  esac
done

if [[ -z "$REMOVE" ]]; then
  info "Hiding network manager icon in tray..."
  gsettings set org.gnome.nm-applet show-applet false
  pkill nm-applet
else
  info "Showing network manager icon in tray..."
  gsettings set gnome.org.nm-applet show-applet true
fi
