#!/usr/bin/env bash

source "$(pwd)/scripts/lib-colors.sh"
source "$(pwd)/scripts/lib-init.sh"
source "$(pwd)/scripts/lib-stow.sh"

delete-file() {
  ((VERBOSE & 1)) && debug "Deleting file '$1'"
  rm -rf $1
}

handle-file-exists() {

  subdebug "OVERWRITE: $OVERWRITE"

  ((OVERWRITE & 1)) && subdebug "Deleting file '$1'" && rm -rf $1 && return

  subwarning "File '$(yellow $1)' exists!"
  read -p " - Overwrite? [y/n]" answer

  if [[ "$answer" =~ ^[Yy]$ ]]; then
    subdebug "Deleting file '$1'" && rm -rf $1
  else
    error "GNU Stow will fail if '$(yellow $1)' already exists. Aborting."
    exit 1
  fi
}

handle-install-packages() {
  info "Installing packages."
}

handle-stow-dotfiles() {
  info "Stowing dotfiles."

  flags=$(get-stow-flags ~/.zshrc)
  ((flags & FLG_EXISTS)) && handle-file-exists ~/.zshrc

  stow-recursive "$(pwd)/stow/core"

  case "$OS_PLATFORM" in
  "darwin")
    stow-recursive "$(pwd)/stow/macos"
    ;;
  "linux")
    echo "Target OS is Linux"
    ;;
  esac

}

handle-show-help() {
  show_help
  exit 1
}

main() {

  # Do nothing but show help if no options were specified.
  ! ((INSTALL_PACKAGES || STOW_DOTFILES)) && handle-show-help

  # Debugging info.
  ((VERBOSE & 1)) && show_debug_command

  info "Starting install."
  ((INSTALL_PACKAGES & 1)) && handle-install-packages || info "$(yellow '--install-packages') option was not passed. Skipping package install."
  ((STOW_DOTFILES & 1)) && handle-stow-dotfiles || info "$(yellow '--stow-dotfiles') option was not passed. Skipping stowing dotfiles."

  info "Finished!"
}

# stow-recursive() {
#   BASE_DIR=$1
#
#   # Check if directory exists
#   if [[ ! -d "$BASE_DIR" ]]; then
#     echo "Directory $BASE_DIR does not exist."
#     exit 1
#   fi
#
#   task-list "Stowing recursively starting from '$(green $BASE_DIR)':"
#
#   # Iterate over subdirectories
#   for dir in "$BASE_DIR"/*/; do
#     # Skip if not a directory
#     [[ -d "$dir" ]] || continue
#
#     # Remove trailing slash and get the name
#     dirname=$(basename "$dir")
#
#     stow "$dirname" -d "$BASE_DIR" -t ~/
#     subtask "Stowing module: '$(green $dirname)'."
#   done
# }
#
# Kick it off!
main
