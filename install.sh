#!/bin/bash

# ##########################################
# _ _  _ ____ ___ ____ _    _     ____ _  _
# | |\ | [__   |  |__| |    |     [__  |__|
# | | \| ___]  |  |  | |___ |___ .___] |  |
#
# ##########################################

# Default values
INSTALL_PACKAGES=false
RUN_STOW=false
VERBOSE=false
OS_PLATFORM=$(uname)
OVERWRITE=false
BACKUP=false
TEST=false

source "$(pwd)/scripts/colors.sh"
source "$(pwd)/scripts/install-lib.sh"

show_debug_command() {
  if [[ "$VERBOSE" == true ]]; then
    echo $(info "install.sh run with the following options:")
    echo -e ""$(debug "--packages | -p: $INSTALL_PACKAGES")
    echo -e ""$(debug "--stow | -s: $RUN_STOW")
    echo -e ""$(debug "--verbose | -v: $VERBOSE")
    echo -e ""$(debug "--force | -f: $OVERWRITE")
    echo -e ""$(debug "--backup | -b: $BACKUP")
    echo -e ""
  fi
}

show_help() {
  cat <<EOF
$(blue $(bold "Usage:")) $(basename "$0") [OPTIONS]

$(blue $(bold "Options:"))
  $(yellow "--packages, -p")    Install all required packages.
  $(yellow "--stow, -s")            Run stow to symlink configuration files.
  $(yellow "--test, -t")                Run -s and -p in 'test' mode.
  $(yellow "-f")                        Overwrite conflicting target files when stowing.
  $(yellow "-b")                        Backup conflicting target files when stowing.
  $(yellow "--help, -h")                Show this help message and exit.

$(blue $(bold "Examples:"))
  $(basename "$0") -ps                  Installs packages and stows dotfiles.
  $(basename "$0") -psf                 Installs packages, and stows dotfiles (overwrites existing dotfiles).
  $(basename "$0") --packages   Installs packages, but does not stow dotfiles.
  $(basename "$0") --stow           Stows dotfiles, but does not install packages.
EOF

  show_debug_command
}

# First, handle long options manually
while [[ "$1" == --* ]]; do
  case "$1" in
  --backup)
    BACKUP=true
    shift
    ;;
  --packages)
    INSTALL_PACKAGES=true
    shift
    ;;
  --stow)
    RUN_STOW=true
    shift
    ;;
  --help)
    show_help
    exit 0
    ;;
  --test)
    echo "Coming soon"
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
while getopts ":psvfb:ht" opt; do
  case ${opt} in
  b)
    BACKUP=true
    ;;
  f)
    OVERWRITE=true
    ;;
  p)
    INSTALL_PACKAGES=true
    ;;
  s)
    RUN_STOW=true
    ;;
  t)
    TEST=true
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

show_debug_command

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

if [[ -L "$HOME/.zprofile" && "$OVERWRITE" == true ]]; then
  warning "'.zprofile' symlink exists. Removing."
  rm "$HOME/.zprofile"
fi

if [[ -f "$HOME/.zprofile" && "$BACKUP" == true ]]; then
  warning "'.zprofile' exists. Making backup."
  mv "$HOME/.zprofile" "$HOME/.zprofile.bak"
fi

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
  echo -e $(info "No $(green --packages) option provided. Skipping $(green $OS_PLATFORM) packages installation.")
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
  echo -e $(info "No $(green --stow) option provided. Skipping $(green $OS_PLATFORM) dotfile installation.")
fi

# # SPECIFIC PLATFORM CONFIGS
# # if [[ "$RUN_STOW" == true && "$INSTALL_PACKAGES" == true ]]; then
# if [[ "$(uname)" == "Darwin" ]]; then
#
#   if [[ "$INSTALL_PACKAGES" == true ]]; then
#     echo "Installing macOS packages via Homebrew."
#     source ./scripts/macos-packages.sh
#   else
#     echo -e $(debug "no --packages option provided. Skipping macOS packages via Homebrew.")
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
