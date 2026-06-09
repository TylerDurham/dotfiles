#!/usr/bin/env bash

NAME="Go Development"
DESCRIPTION="Golang development utilities and tools."

# Libs
source "$(git rev-parse --show-toplevel)/install.d/lib.sh"

if [[ -z "$REVERT" ]]; then
  info "Installing '$(bold_green $NAME)'"
  sys-pkg-install go
else
  info "Uninstalling '$NAME'..."

  sys-pkg-uninstall go
fi

