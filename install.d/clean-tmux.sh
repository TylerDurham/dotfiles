#!/usr/bin/env bash

ROOT_DIR=$(git rev-parse --show-toplevel)
TMUX_CONFIG="$HOME/.config/tmux"

if [[ -L "$TMUX_CONFIG" ]]; then
  echo "'$TMUX_CONFIG' is symlinked! Deleting..."
  path=$(realpath "$TMUX_CONFIG")
  rm "$TMUX_CONFIG"
elif [[ -d "$TMUX_CONFIG" ]]; then
  echo "'$TMUX_CONFIG' is a directory! Backing up..."
  mv "$TMUX_CONFIG" "$TMUX_CONFIG.bak"
else
  echo "No idea!"
fi
