#!/usr/bin/env bash

# Load environment variables
source "$(git rev-parse --show-toplevel)/install.d/envs.sh"

# Libs
if ! . "$USER_LIB_DIR/bash/require.sh" logger; then
    echo "Could not load libraries from '$USER_LIB_DIR'!" >&2
    exit 1
fi

GETTY_DROP_IN=/etc/systemd/system/getty@tty1.service.d
GETTY_CONF=$GETTY_DROP_IN/autologin.conf

# Parse args and flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    -r|--remove) REMOVE=1; shift ;;
  esac
done

if [[ -n "$REMOVE" ]]; then
  sudo rm -rf "$GETTY_DROP_IN"
  sudo systemctl daemon-reload
else
  sudo mkdir -p "$GETTY_DROP_IN"

cat << EOF | sudo tee "$GETTY_CONF"
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER --noclear %I \$TERM
EOF

  sudo systemctl daemon-reload
fi
