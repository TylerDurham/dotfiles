#!/usr/bin/env bash

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
  -r | --remove)
    REMOVE=1
    shift
    ;;
  esac
done

info "Setting theme to 'lovely-day' by linking at '$USER_CONFIG_DIR/current'..."
ln -sf "$USER_THEME_DIR/.local/share/dtd/themes/lovely-day" "$USER_CONFIG_DIR/current"
