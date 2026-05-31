#!/usr/bin/env bash

# ####################################################################
#
#  ██████╗████████╗██╗  ██╗     ██╗ ██████╗ ██████╗ ███╗   ██╗███████╗
# ██╔════╝╚══██╔══╝██║ ██╔╝     ██║██╔════╝██╔═══██╗████╗  ██║██╔════╝
# ██║  ███╗  ██║   █████╔╝█████╗██║██║     ██║   ██║██╔██╗ ██║███████╗
# ██║   ██║  ██║   ██╔═██╗╚════╝██║██║     ██║   ██║██║╚██╗██║╚════██║
# ╚██████╔╝  ██║   ██║  ██╗     ██║╚██████╗╚██████╔╝██║ ╚████║███████║
#  ╚═════╝   ╚═╝   ╚═╝  ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
# ####################################################################

source "$USER_LIB_DIR/bash/logger.sh"

ICON_THEME="Tela-circle-dracula"
ICON_THEME_URL="https://github.com/vinceliuice/Tela-circle-icon-theme.git"
CWD=$(pwd)

if [[ -d "$HOME/.local/share/icons/$ICON_THEME" ]]; then
  # Icons exist... don't install again
  info "Icon theme '$ICON_THEME' already installed..." | indent 4
else
  TMP_DIR="$(mktemp -d)"
  # trap cd $CWD && 'rm -rf "$TMP_DIR"' EXIT

  info "Ensuring packages are installed."
  sys-pkg-install nwg-look

  info "Downloading source code to '$TMP_DIR'..."
  git clone $ICON_THEME_URL "$TMP_DIR"

  info "Installing theme(s)..."
  $TMP_DIR/install.sh -n Tela-circle-dracula -c

  info "Saving gsettings..."
  gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME" # for GTK4 apps

  ok "Done installing themes!"
  rm -rf "$TMP_DIR"
fi
