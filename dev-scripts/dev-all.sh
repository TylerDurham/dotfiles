#!/usr/bin/env bash
#
# dev-hypr.sh — Hot-swap ~/.config/hypr with the dotfiles repo version for live development.
#
# Usage:
#   ./scripts/dev-hypr.sh           Back up ~/.config/waybar and symlink the repo's
#                                     .config/waybar in its place, then restart waybar.
#   ./scripts/dev-hypr.sh --revert  Remove the symlink and restore the original backup.
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

cleanup() {
  echo ""
  info "Stopping watch!"

  $CWD/dev-bin.sh -r
  $CWD/dev-shared.sh -r
  $CWD/dev-waybar.sh -r
  $CWD/dev-hypr.sh -r

  hyprctl reaload
  killall -SIGUSR2 waybar

  notice "Reload yer shell, ya filthy animal!"
}

trap cleanup EXIT

$CWD/dev-bin.sh
$CWD/dev-shared.sh
$CWD/dev-waybar.sh
$CWD/dev-hypr.sh

hyprctl reload
killall -SIGUSR2 waybar

source $CWD/watch.sh
