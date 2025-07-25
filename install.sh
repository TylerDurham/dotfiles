#!/usr/bin/env bash

source "$(pwd)/scripts/lib-colors.sh"
source "$(pwd)/scripts/lib-init.sh"

handle-install-packages() {
  info "Installing packages."
}

handle-stow-dotfiles() {
  info "Stowing dotfiles."
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

# Kick it off!
main
