#!/usr/bin/env bash

# ##########################################################################
#
#  █████╗ ██╗   ██╗████████╗ ██████╗ ██╗      ██████╗  ██████╗ ██╗███╗   ██╗
# ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██║     ██╔═══██╗██╔════╝ ██║████╗  ██║
# ███████║██║   ██║   ██║   ██║   ██║██║     ██║   ██║██║  ███╗██║██╔██╗ ██║
# ██╔══██║██║   ██║   ██║   ██║   ██║██║     ██║   ██║██║   ██║██║██║╚██╗██║
# ██║  ██║╚██████╔╝   ██║   ╚██████╔╝███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║
# ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝
# ##########################################################################

# Load environment variables
source "$(git rev-parse --show-toplevel)/install.d/envs.sh"

# Libs
if ! . "$USER_LIB_DIR/bash/require.sh" logger; then
    echo "Could not load libraries from '$USER_LIB_DIR'!" >&2
    exit 1
fi

# Where is this file located at?
CWD=$(dirname $(realpath $0))

# Parse args and flags
while [[ $# -gt 0 ]]; do 
  case "$1" in 
    -r|--remove) REMOVE=1; shift ;;
  esac
done

if [[ -n "$REMOVE" ]]; then
  sudo rm -rf /etc/sddm.conf.d/autologin.conf
else
  sudo mkdir -p /etc/sddm.conf.d

cat << EOF | sudo tee /etc/sddm.conf.d/autologin.conf
[Autologin]
User=$USER
Session=hyprland
EOF
fi
