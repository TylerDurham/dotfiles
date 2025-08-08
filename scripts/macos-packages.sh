# TODO: Add uv for python
SNORK_PACKAGES=("bash" "tmux" "neovim" "ripgrep" "zoxide" "fzf" "tree" "starship" "stow" "bat" "gum")
INSTALL_PACKAGES=("gum")
SNORK_CASKS=("alacritty" "aerospace" "font-fira-code-nerd-font")

# Sort and overwrite
IFS=$'\n' SNORK_PACKAGES=($(sort <<<"${SNORK_PACKAGES[*]}"))
unset IFS

check_cask() {
  cask=$1

  if brew list --cask | grep -q "$cask"; then
    echo -e $(task-warning "Cask '$(green $cask)' is installed. Nothing to do.")
  else
    echo -e $(task "Cask '$(green $cask)' is not installed. Installing now.")
    install_package "brew" "install" "--cask" "$cask"
  fi
}

check_package() {
  package=$1

  if brew list --formula | grep -q "$package"; then
    echo -e $(task-warning "Package '$(green $package)' is installed. Nothing to do.")
  else

    echo -e $(info "Package '$(green $package)' is not installed. Installing now.")
    install_package "brew" "install" "$package"
  fi
}

# No Homebrew? No bueno...
if command -v brew >/dev/null 2>&1; then
  task-section "Homebrew installed. Proceeding with installing packages."
else
  error "Homebrew is NOT installed. Terminating.\n"
  echo "Install Homebrew at https://brew.sh"
  exit 127
fi

# Install casks.
for cask in "${SNORK_CASKS[@]}"; do
  check_cask "$cask"
done

# Install packages
for package in "${SNORK_PACKAGES[@]}"; do
  check_package "$package"
done

# Unlock from quarantine
xattr -d com.apple.quarantine /Applications/AeroSpace.app
xattr -d com.apple.quarantine /Applications/Alacritty.app

if grep -Fxq "/opt/homebrew/bin/bash" /etc/shells; then
  info "New bash path already present. Nothing to do. \n"
else
  warning "Adding new bash to /etc/shells. You may be prompted for your password!"
  echo ""
  echo "/opt/homebrew/bin/bash" | sudo tee -a /etc/shells
fi
