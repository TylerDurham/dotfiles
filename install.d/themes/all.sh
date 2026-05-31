#!/usr/bin/env bash

# ####################################################
#
# ████████╗██╗  ██╗███████╗███╗   ███╗███████╗███████╗
# ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝██╔════╝
#    ██║   ███████║█████╗  ██╔████╔██║█████╗  ███████╗
#    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝  ╚════██║
#    ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗███████║
#    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝╚══════╝
# ####################################################

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Load environment variables
source "$(git rev-parse --show-toplevel)/install.d/envs.sh"

# Libs
if ! . "$USER_LIB_DIR/bash/require.sh" logger; then
    echo "Could not load libraries from '$USER_LIB_DIR'!" >&2
    exit 1
fi

# Where is this file located at?
CWD=$(dirname $(realpath $0))

# Modules to be executed, in order
MODULES=(
  gtk.sh
  gtk-icons.sh
  default-theme.sh
)

# Parse args and flags
while [[ $# -gt 0 ]]; do 
  case "$1" in 
    -r|--remove) REMOVE=1; shift ;;
  esac
done

if [[ -n "$REMOVE" ]]; then

  warn "Not supported - yet!"
  # # Loop backward over array and call ---remove on each module to uninstall
  # i=${#MODULES[@]}-1
  # while (( i >= 0 )); do
  #   MODULE=${MODULES[i]}
  #   module "Executing '$(basename $CWD)/$MODULE --remove' for remove..."
  #   $CWD/$MODULE --remove
  #     (( i-- ))
  # done
  exit 0
fi

for MODULE in ${MODULES[@]}; do 
  module "Executing '$(basename $CWD)/$MODULE' for install..."
  $CWD/$MODULE
done

