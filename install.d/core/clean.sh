#!/usr/bin/env bash

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
  else
    [[ -e "$path" ]] &&
      notice "Backing up '$path' to '$backup'..." ||
      debug "'$path' does not exist! Nothing to do..."
  fi
done
