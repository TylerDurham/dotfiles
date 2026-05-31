#!/usr/bin/env bash
#
# dev-waybar.sh — Hot-swap ~/.config/waybar with the dotfiles repo version for live development.
#
# Usage:
#   ./scripts/dev-waybar.sh           Back up ~/.config/waybar and symlink the repo's
#                                     .config/waybar in its place, then restart waybar.
#   ./scripts/dev-waybar.sh --revert  Remove the symlink and restore the original backup.
#
# This lets you edit waybar config inside the dotfiles repo and see changes
# immediately without manually copying files back and forth. The original
# ~/.config/waybar is preserved as ~/.config/waybar.bak so --revert is safe.

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Source our "dev" envs
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
    -r|--revert) REVERT=1; shift ;;
  esac
done

APP="waybar"
TARGET="$HOME/.config/$APP"
DEV_SRC="$PROJECT_ROOT_DIR/.config/$APP"

if [[ -n "$REVERT" ]]; then
  warn "Reverting back to original target '$TARGET'..."
  rm "$TARGET"
  mv "$TARGET.bak" "$TARGET"
else 
  warn "Backing up original target '$TARGET'..."
  mv "$TARGET" "$TARGET.bak"

  warn "Linking '$DEV_SRC' to '$TARGET'..."
  ln -s "$DEV_SRC" "$TARGET"
fi

if [[ -x "$PROJECT_ROOT_DIR/.local/bin/hypr-restart-$APP" ]]; then
  $PROJECT_ROOT_DIR/.local/bin/hypr-restart-$APP
fi

