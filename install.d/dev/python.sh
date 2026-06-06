#!/usr/bin/env bash

NAME="Python Development"
DESCRIPTION="Python development utilities and tools."

# Libs
source "$(git rev-parse --show-toplevel)/install.d/lib.sh"

if [[ -z "$REVERT" ]]; then
  info "Installing '$(bold_green $NAME)'"
  echo "$DESCRIPTION" | indent 2

  debug "Installing astral uv..." | indent 2
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  info "Uninstalling '$NAME'..."

  debug "Removing astral uv..."

  uv cache clean
  rm -r "$(uv python dir)"
  rm -r "$(uv tool dir)"
  
  rm ~/.local/bin/uv ~/.local/bin/uvx
fi
