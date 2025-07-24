SNORK_PACKAGES=("tmux" "neovim" "ripgrep" "zoxide" "fzf" "tree" "starship" "stow" "bat" "gum")
INSTALL_PACKAGES=("gum")
SNORK_CASKS=("alacritty" "nikitabobko/tap/aerospace" "font-fira-code-nerd-font")

# Sort and overwrite
IFS=$'\n' SNORK_PACKAGES=($(sort <<<"${SNORK_PACKAGES[*]}"))
unset IFS

check_cask() {
  cask=$1

  if brew list --cask | grep -q "$cask"; then
    echo -e "\tCask '$cask' is installed. Nothing to do."
  else
    echo -e "\tCask '$cask' is not installed. Installing now."
    brew install --cask "$cask"
  fi
}

check_package() {
  package=$1

  if brew list --formula | grep -q "$package"; then
    echo -e "\tPackage '$package' is installed. Nothing to do."
  else

    echo -e "\tPackage '$package' is not installed. Installing now."
    brew install "$package"
  fi
}

# No Homebrew? No bueno...
if command -v brew >/dev/null 2>&1; then
  echo $(info "Homebrew installed. Proceeding.")
else
  echo "Homebrew is NOT installed. Termininating."
  echo "Install Homebrew at https://brew.sh/"
  exit 127
fi

if [[ "$NO_PACKAGES" == false ]]; then

  # Install casks.
  for cask in "${SNORK_CASKS[@]}"; do
    # check_cask "$cask"
    install_package "brew" "install" "--cask" "$cask"
  done

  # Install packages
  for package in "${SNORK_PACKAGES[@]}"; do
    # check_package "$package"
    install_package "brew" "install" "$package"
  done
else
  if [[ "$VERBOSE" == true ]]; then
    echo $(debug "'--no-packages' option provided. Nothing to do.")
  fi
fi

# Unlock from quarantine
xattr -d com.apple.quarantine /Applications/AeroSpace.app
xattr -d com.apple.quarantine /Applications/Alacritty.app
