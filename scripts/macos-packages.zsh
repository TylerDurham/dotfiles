SNORK_PACKAGES=("tmux" "neovim" "ripgrep" "zoxide" "fzf" "tree" "starship" "stow" "bat" "alacritty" "nikitabobko/tap/aerospace")

# Sort and overwrite
IFS=$'\n' SNORK_PACKAGES=($(sort <<<"${SNORK_PACKAGES[*]}"))
unset IFS

check_package() {
  package=$1

  if brew list --formula | grep -q "$package"; then
    echo -e "\t$package is installed. Nothing to do."
  else
    echo -e "\t$package is not installed. Installing now."
    brew install "$package"
  fi
}

for package in "${SNORK_PACKAGES[@]}"; do
  check_package "$package"
done

export SNORK_PACKAGES
