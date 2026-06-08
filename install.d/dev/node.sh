#!/usr/bin/env bash

echo ">>> Fetching latest nvm version..."
NVM_VERSION=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name"' | cut -d'"' -f4)

echo ">>> Installing nvm ${NVM_VERSION}..."
curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash

# 2. Load nvm into current shell session
export NVM_DIR="$HOME/.nvm"

# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

nvm install "--lts"
