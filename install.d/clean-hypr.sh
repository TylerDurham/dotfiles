#!/usr/bin/env bash

ROOT_DIR=$(git rev-parse --show-toplevel)
HYPR_CONFIG="$HOME/.config/hypr"

if [[ -L "$HYPR_CONFIG" ]]; then
  echo "'$HYPR_CONFIG' is symlinked! Deleting..."
  path=$(realpath "$HYPR_CONFIG")
  rm "$HYPR_CONFIG"
elif [[ -d "$HYPR_CONFIG" ]]; then
  echo "'$HYPR_CONFIG' is a directory! Backing up..."
  mv "$HYPR_CONFIG" "$HYPR_CONFIG.bak"
else
  echo "No idea!"
fi
