# #######################################################
#
# ██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗
# ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔════╝
# █████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ███╗
# ██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║   ██║
# ██║  ██╗███████╗   ██║   ██║  ██║██║██║ ╚████║╚██████╔╝
# ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝
# #######################################################
# This script sets up a pre-configured GNOME keyring that Brave (and other apps using libsecret) will use without prompting for a password on unlock.
#
# Here's what each part does:
#
# Creates the keyring directory (~/.local/share/keyrings/) — the standard location where gnome-keyring (via libsecret) looks for keyrings.
#
# Writes Default_keyring.keyring — a keyring definition file with two critical flags:
# - lock-on-idle=false — the keyring won't lock when the session goes idle
# - lock-after=false — the keyring won't lock after a timeout
#
# Together these prevent the keyring daemon from locking the keyring, which is what triggers the password prompt when Brave tries to access saved credentials.
#
# Writes the default file — tells gnome-keyring which keyring is the default. Brave checks this file to know which keyring to unlock for storing/reading passwords.
#
# Sets permissions — 700 on the directory and 600 on the keyring file restrict access to your user only, which is correct for secrets storage. The default pointer file gets 644 since it's just a name reference.
#
# The net effect: Brave finds a default keyring that is configured to never auto-lock, so it never needs to prompt you to unlock it. The trade-off is that the keyring isn't password-protected, so anyone with access to your filesystem can read its contents.

KEYRING_DIR="$HOME/.local/share/keyrings"
KEYRING_FILE="$KEYRING_DIR/Default_keyring.keyring"
DEFAULT_FILE="$KEYRING_DIR/default"

mkdir -p "$KEYRING_DIR"

cat <<EOF >"$KEYRING_FILE"
[keyring]
display-name=Default keyring
ctime=$(date +%s)
mtime=0
lock-on-idle=false
lock-after=false
EOF

cat <<EOF >"$DEFAULT_FILE"
Default_keyring
EOF

chmod 700 "$KEYRING_DIR"
chmod 600 "$KEYRING_FILE"
chmod 644 "$DEFAULT_FILE"

NAME="Keyring File"
DESCRIPTION="This script sets up a pre-configured GNOME keyring that Brave (and other apps using libsecret) will use without prompting for a password on unlock."

# Libs
source "$(git rev-parse --show-toplevel)/install.d/lib.sh"

init-keyring() {

  mkdir -p "$KEYRING_DIR"

  cat <<EOF >"$KEYRING_FILE"
[keyring]
display-name=Default keyring
ctime=$(date +%s)
mtime=0
lock-on-idle=false
lock-after=false
EOF

  cat <<EOF >"$DEFAULT_FILE"
Default_keyring
EOF

  chmod 700 "$KEYRING_DIR"
  chmod 600 "$KEYRING_FILE"
  chmod 644 "$DEFAULT_FILE"
}

if [[ -z "$REVERT" ]]; then
  info "Installing '$(bold_green $NAME)'"
  init-keyring
else
  info "Uninstalling '$NAME'..."
  rm $KEYRING_FILE
  rm $DEFAULT_FILE
fi
