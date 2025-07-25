#!/usr/bin/env bash

source "$(pwd)/scripts/lib-colors.sh"
source "$(pwd)/scripts/lib-init.sh"

handle-install-packages() {
  info "Installing packages."
}

handle-stow-dotfiles() {
  info "Stowing dotfiles."
}

main() {
  info "Starting install."

  show_debug_command

  ((INSTALL_PACKAGES & 1)) && handle-install-packages || info "$(yellow '--install-packages') option was not passed. Skipping package install."
  ((STOW_DOTFILES & 1)) && handle-stow-dotfiles || info "$(yellow '--stow-dotfiles') option was not passed. Skipping stowing dotfiles."

  info "Finished!"
}

# Kick it off!
main
