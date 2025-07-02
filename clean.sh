#!/bin/bash

# Usage: ./iterate_subdirs.sh /path/to/directory
#

FORCE=false

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
  -f | --force)
    FORCE=true
    shift
    ;;
  --) # end of options
    shift
    break
    ;;
  -*)
    echo "Unknown option: $1"
    exit 1
    ;;
  *)
    break
    ;;
  esac
done

# Example usage
if $FORCE; then
  echo "Force mode enabled"
else
  echo "Force mode disabled"
fi

check_and_clean() {
  exists=$([[ -e "$1" ]] && echo true || echo false)
  is_symlink=$([[ -L "$1" ]] && echo true || echo false)

  echo "Checking $1: exists=$exists, is_symlink=$is_symlink"

  if $is_symlink; then
  echo "Removing '$1'..."

  rm -rf "$1" 2>/dev/null

  echo "$1 removed!"
  fi
}

check_and_clean ~/.zshrc

MODULES=(".config" ".local/bin")
for module in "${MODULES[@]}"; do
  echo "Cleaning module '$module':"

  for item in "$module"/* "$module"/.*; do
    [[ -e "$item" && "$item" != "$module/." && "$item" != "$module/.." ]] || continue
    check_and_clean "${HOME}/$item"
  done

done
