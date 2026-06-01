PROJECT_ROOT_DIR=$(git rev-parse --show-toplevel)
USER_INSTALL_DIR=$(git rev-parse --show-toplevel)

init() {
  # Libs
  if ! . "$USER_LIB_DIR/bash/require.sh" logger; then
    echo "Could not load libraries from '$USER_LIB_DIR'!" >&2
    exit 1
  fi

  # Where is this file located at?
  CWD=$(dirname $(realpath $0))

  # Parse args and flags
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -r | --revert)
      REVERT=1
      shift
      ;;
    esac
  done
}

export USER_LIB_DIR="$PROJECT_ROOT_DIR/.local/share/dtd/lib/"
export USER_CONFIG_DIR="$HOME/.config/dtd"
export USER_BIN_DIR="$PROJECT_ROOT_DIR/.local/bin"
export USER_THEME_DIR="$PROJECT_ROOT_DIR/.local/share/dtd/themes"
export USER_CURRENT_THEME_DIR="$USER_CONFIG_DIR/current"
export PATH="$USER_BIN_DIR:$PATH"
