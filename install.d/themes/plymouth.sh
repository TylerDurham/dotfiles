#!/usr/bin/env bash

source "$(git rev-parse --show-toplevel)/install.d/envs.sh"

# Libs
if ! . "$USER_LIB_DIR/bash/require.sh" logger; then
  echo "Could not load libraries from '$USER_LIB_DIR'!" >&2
  exit 1
fi

# Where is this file located at?
CWD=$(dirname $(realpath $0))

THEMES=$(find $CWD/plymouth -mindepth 1 -type d)
PLYMOUTH_THEMES=/usr/share/plymouth/themes

for theme in ${THEMES[@]}; do
  name=$(basename $theme)
  info "Installing plymouth theme '$name' to '$PLYMOUTH_THEMES'..."
  sudo cp -r $theme $PLYMOUTH_THEMES
done

sudo plymouth-set-default-theme -R target
