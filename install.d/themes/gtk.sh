
#!/usr/bin/env bash
# ################################################################
# _____________________ __    _____________
# __  ____/__  __/__  //_/    ___  __/__  /_____________ ________
# _  / __ __  /  __  ,<       __  /  __  __ \  _ \_  __ `__ \  _ \
# / /_/ / _  /   _  /| |      _  /   _  / / /  __/  / / / / /  __/
# \____/  /_/    /_/ |_|      /_/    /_/ /_/\___//_/ /_/ /_/\___/
#
# ################################################################

source "$USER_LIB_DIR/bash/logger.sh"
THEME="Graphite-Dark"
THEME_URL="https://github.com/vinceliuice/Graphite-gtk-theme.git"

if [[ -d "$HOME/.local/share/themes/$THEME" ]]; then
  # Theme exist... don't install again
  debug "Theme '$THEME' already installed..." | indent 4
  exit 0
else

  CWD=$(pwd)

  TMP_DIR="$(mktemp -d)"

  info "Ensuring packages are installed."
  sys-pkg-install nwg-look

  info "Downloading source code to '$TMP_DIR'..."
  git clone $THEME_URL "$TMP_DIR"

  info "Installing theme(s)..."
  $TMP_DIR/install.sh --theme all --libadwaita -n Graphite -c dark --tweaks rimless black normal

  info "Saving gsettings..."
  gsettings set org.gnome.desktop.interface gtk-theme "$THEME-Dark"  # for GTK3 apps
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" # for GTK4 apps

  ok "Done installing themes!"

  rm -rf "$TMP_DIR"
fi
