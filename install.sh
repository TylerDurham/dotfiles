#!/bin/bash

# Default values
INSTALL_PACKAGES=false
RUN_STOW=false
VERBOSE=false
OS_PLATFORM=$(uname)

source "$(pwd)/scripts/colors.sh"
source "$(pwd)/scripts/install-lib.sh"

show_help() {
  cat <<EOF
$(blue $(bold "Usage:")) $(basename "$0") [OPTIONS]

$(blue $(bold "Options:"))
  $(yellow "--install-packages, -p")   Install all required packages
  $(yellow "--run-stow, -s")           Run stow to symlink configuration files
  $(yellow "--help, -h")               Show this help message and exit

$(blue $(bold "Examples:"))
  $(basename "$0") -ps
  $(basename "$0") --install-packages
EOF
}

# First, handle long options manually
while [[ "$1" == --* ]]; do
  case "$1" in
  --install-packages)
    INSTALL_PACKAGES=true
    shift
    ;;
  --run-stow)
    RUN_STOW=true
    shift
    ;;
  --help)
    show_help
    exit 0
    ;;
  --) # end of long options
    shift
    break
    ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
done

# Now handle short options with getopts
while getopts ":psv:h" opt; do
  case ${opt} in
  p)
    INSTALL_PACKAGES=true
    ;;
  s)
    RUN_STOW=true
    ;;
  v)
    VERBOSE=true
    ;;
  h)
    show_help
    exit 0
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

if [[ "$INSTALL_PACKAGES" == false && "$RUN_STOW" == false ]]; then
  show_help
  exit 1
fi

echo $(info "install.sh run with the following options:")
echo -e ""$(info "install packages: $INSTALL_PACKAGES")
echo -e ""$(info "run stow: $RUN_STOW")
echo -e ""$(info "verbose: $VERBOSE")
echo -e ""
# Directory to iterate

stow-recursive() {
  BASE_DIR=$1

  # Check if directory exists
  if [[ ! -d "$BASE_DIR" ]]; then
    echo "Directory $BASE_DIR does not exist."
    exit 1
  fi

  # Iterate over subdirectories
  for dir in "$BASE_DIR"/*/; do
    # Skip if not a directory
    [[ -d "$dir" ]] || continue

    # Remove trailing slash and get the name
    dirname=$(basename "$dir")

    # Example action (replace with your command)
    # echo "Running stow for $dirname"
    if [[ "$RUN_STOW" == false ]]; then
      stow "$dirname" -d "$BASE_DIR" -t ~/
      echo -e "\tStowing module: '$dirname'."
    else
      echo -e "\t'--no-stow' option passed. Not actually stowing module: '$dirname'."
    fi

  done
}

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

if [[ "$INSTALL_PACKAGES" == true ]]; then
  case "$OS_PLATFORM" in
  Darwin)
    task-section "Installing macOS packages via Homebrew."
    source ./scripts/macos-packages.sh
    ;;
  Linux)
    echo "Linux!"
    ;;
  *)
    error "Unsupported platform $OS_PLATFORM!"
    exit 1
    ;;
  esac
else
  echo -e $(info "No $(green --install-packages) option provided. Skipping $(green $OS_PLATFORM) packages installation.")
fi

if [[ "$RUN_STOW" == true ]]; then
  task-section "Installing core 'stow' packages."
  stow_packages ./stow/core/

  case "$OS_PLATFORM" in
  Darwin)
    task-section "Installing macOS dotfiles via GNU Stow."
    stow_packages ./stow/macos/

    ;;
  Linux)
    echo "Linux!"
    ;;
  *)
    error "Unsupported platform $OS_PLATFORM!"
    exit 1
    ;;
  esac
else
  echo -e $(info "No $(green --run-stow) option provided. Skipping $(green $OS_PLATFORM) dotfile installation.")
fi

# # SPECIFIC PLATFORM CONFIGS
# # if [[ "$RUN_STOW" == true && "$INSTALL_PACKAGES" == true ]]; then
# if [[ "$(uname)" == "Darwin" ]]; then
#
#   if [[ "$INSTALL_PACKAGES" == true ]]; then
#     echo "Installing macOS packages via Homebrew."
#     source ./scripts/macos-packages.sh
#   else
#     echo -e $(debug "no --install-packages option provided. Skipping macOS packages via Homebrew.")
#   fi
#
#   echo "Installing macOS specific 'stow' packages."
#   stow_packages ./stow/macos/
# else
#   echo "TODO: Linux specific stow packages."
#   stow_packages ./stow/linux/
# fi
#
# echo "Installing core 'stow' packages."
# stow_packages ./stow/core/
#
# echo "All casks and packages installed for $(uname)!"
