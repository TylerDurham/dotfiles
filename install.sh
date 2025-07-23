#!/bin/bash

# Directory to iterate

stow-recursive() {
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

    echo -e "\tStowing module: $dirname"

    # Example action (replace with your command)
    # echo "Running stow for $dirname"
    stow "$dirname" -d "$BASE_DIR" -t ~/

  done
}

if [[ -L "$HOME/.zprofile" ]]; then
  echo "WARNING: '.zprofile' symlink exists. Removing."
  rm "$HOME/.zprofile"
fi

if [[ -f "$HOME/.zprofile" ]]; then
  echo "WARNING: '.zprofile' exists. Making backup."
  mv "$HOME/.zprofile" "$HOME/.zprofile.bak"
fi

if [[ -L "$HOME/.zshrc" ]]; then
  echo "WARNING: '.zshrc' symlink exists. Removing."
  rm "$HOME/.zshrc"
fi

if [[ -f "$HOME/.zshrc" ]]; then
  echo "WARNING: '.zshrc' exists. Making backup."
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

exit 0
# SPECIFIC PLATFORM CONFIGS
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Installing macOS packages via Homebrew."
  source ./scripts/macos-packages.zsh

  echo "Installing macOS specific 'stow' packages."
  stow-recursive ./stow/macos/
else
  echo "TODO: Linux specific stow packages."
  stow-recursive ./stow/linux/
fi

echo "Installing core 'stow' packages."
stow-recursive ./stow/core/

echo "All casks and packages installed for macOs!"
