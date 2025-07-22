#!/bin/bash

# Directory to iterate

unstow-recursive() {
  BASE_DIR=$1

  # Check if directory exists
  if [[ ! -d "$BASE_DIR" ]]; then
    echo "Directory $BASE_DIR does not exist."
    exit 1
  fi

  # Iterate over subdirectories
  for dir in "$BASE_DIR"/*/; do
    # Skip if not a directory
    [[ -d "$dir" ]] || continue

    # Remove trailing slash and get the name
    dirname=$(basename "$dir")

    echo -e "\tUnstowing module: $dirname"

    # Example action (replace with your command)
    # echo "Running stow for $dirname"
    stow -D "$dirname" -d "$BASE_DIR" -t ~/

  done

}

echo "Uninstalling core 'stow' packages."
unstow-recursive ./stow/core/

# SPECIFIC PLATFORM CONFIGS
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Uninstalling macOS specific 'stow' packages."
  unstow-recursive ./stow/macos/
else
  echo "TODO: Linux specific stow packages."
  unstow-recursive ./stow/linux/
fi
