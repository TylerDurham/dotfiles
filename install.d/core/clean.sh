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

PATHS=(
  ~/.bashrc
  ~/.zshrc
)
for path in ${PATHS[@]}; do
  backup="$path.bak"
  if [[ -n "$REMOVE" ]]; then
    [[ -e "$backup" ]] &&
      notice "Restoring up '$backup' to '$path'..." ||
      debug "'$backup' does not exist! Nothing to do..."

    [[ -e "$backup" ]] && mv "$backup" "$path"
  else
    [[ -e "$path" ]] &&
      notice "Backing up '$path' to '$backup'..." ||
      debug "'$path' does not exist! Nothing to do..."

    [[ -e "$path" ]] && mv "$path" "$backup"
  fi
done
