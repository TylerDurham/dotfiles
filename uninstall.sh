#!/usr/bin/env bash

# Unstow the shared files
stow -D @core -t ~/

# SPECIFIC PLATFORM CONFIGS
if [[ "$(uname)" == "Darwin" ]]; then
  stow -D @macos -t ~/
else
  stow -D @linux -t ~/
fi
