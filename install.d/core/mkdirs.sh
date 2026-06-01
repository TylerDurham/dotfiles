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

DIRECTORIES=(
  "$HOME/.local/bin"
  "$HOME/.local/shared/dtd"
  ~/.config/{dtd,current,hypr,waybar,rofi,1Pasword}
)

for DIR in "${DIRECTORIES[@]}"; do
  if [[ -z "$REMOVE" ]]; then
    info "Creating directory at '$DIR'..."
    mkdir -p "$DIR"
  else
    warn "Removing directory at '$DIR'..."
    rm -rf "$DIR"
  fi
done
