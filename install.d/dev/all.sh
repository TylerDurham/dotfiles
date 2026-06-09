#!/usr/bin/env bash

# #########################
#
# ██████╗ ███████╗██╗   ██╗
# ██╔══██╗██╔════╝██║   ██║
# ██║  ██║█████╗  ██║   ██║
# ██║  ██║██╔══╝  ╚██╗ ██╔╝
# ██████╔╝███████╗ ╚████╔╝
# ╚═════╝ ╚══════╝  ╚═══╝
# #########################

MODULES=(
  go.sh
  node.sh
  python.sh
)

NAME="Development"
DESCRIPTION="All my development utilities and tools."

# Libs
source "$(git rev-parse --show-toplevel)/install.d/lib.sh"

if [[ -n "$REVERT" ]]; then
  # Loop backward over array and call ---remove on each module to uninstall
  i=${#MODULES[@]}-1
  while ((i >= 0)); do
    MODULE=${MODULES[i]}
    module "Executing '$(basename $CWD)/$MODULE --remove' for remove..."
    $CWD/$MODULE --remove
    ((i--))
  done
  exit 0
fi

for MODULE in ${MODULES[@]}; do
  module "Executing '$(basename $CWD)/$MODULE' for install..."
  $CWD/$MODULE
done

