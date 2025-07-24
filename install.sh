#!/bin/bash

source "$(pwd)/scripts/install-lib.sh"

# Directory to iterate

# stow-recursive() {
#   BASE_DIR=$1
#
#   # Check if directory exists
#   if [[ ! -d "$BASE_DIR" ]]; then
#     echo "Directory $BASE_DIR does not exist."
#     exit 1
#   fi
#
#   # Iterate over subdirectories
#   for dir in "$BASE_DIR"/*/; do
#     # Skip if not a directory
#     [[ -d "$dir" ]] || continue
#
#     # Remove trailing slash and get the name
#     dirname=$(basename "$dir")
#
#     # Example action (replace with your command)
#     # echo "Running stow for $dirname"
#     if [[ "$NO_STOW" == false ]]; then
#       stow "$dirname" -d "$BASE_DIR" -t ~/
#       echo -e "\tStowing module: '$dirname'."
#     else
#       echo -e "\t'--no-stow' option passed. Not actually stowing module: '$dirname'."
#     fi
#
#   done
# }

########################################
# if [[ -L "$HOME/.zprofile" ]]; then
#   echo "WARNING: '.zprofile' symlink exists. Removing."
#   rm "$HOME/.zprofile"
# fi
#
# if [[ -f "$HOME/.zprofile" ]]; then
#   echo "WARNING: '.zprofile' exists. Making backup."
#   mv "$HOME/.zprofile" "$HOME/.zprofile.bak"
# fi
#
# if [[ -L "$HOME/.zshrc" ]]; then
#   echo "WARNING: '.zshrc' symlink exists. Removing."
#   rm "$HOME/.zshrc"
# fi
#
# if [[ -f "$HOME/.zshrc" ]]; then
#   echo "WARNING: '.zshrc' exists. Making backup."
#   mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
# fi

# SPECIFIC PLATFORM CONFIGS
# if [[ "$NO_STOW" == true && "$NO_PACKAGES" == true ]]; then
if [[ "$(uname)" == "Darwin" ]]; then

  if [[ "$NO_PACKAGES" == false ]]; then
    echo "Installing macOS packages via Homebrew."
    source ./scripts/macos-packages.sh
  else
    if [[ "$VERBOSE" == true ]]; then
      echo -e $(debug "--no-install options provided. Skipping macOS packages via Homebrew.")
    fi
  fi

  echo "Installing macOS specific 'stow' packages."
  stow_packages ./stow/macos/
else
  echo "TODO: Linux specific stow packages."
  stow_packages ./stow/linux/
fi

echo "Installing core 'stow' packages."
stow_packages ./stow/core/

echo "All casks and packages installed for $(uname)!"
