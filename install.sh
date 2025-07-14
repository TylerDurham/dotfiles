#!/usr/bin/env bash

# Stow the shared files
stow @core -t ~/

# SPECIFIC PLATFORM CONFIGS
if [[ "$(uname)" == "Darwin" ]]; then
  stow @macos -t ~/
else
  stow @linux -t ~/
fi
