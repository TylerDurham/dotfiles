PROJECT_ROOT_DIR=$(git rev-parse --show-toplevel)
USER_INSTALL_DIR=$(git rev-parse --show-toplevel)

# [[ -z $USER_LIB_DIR ]] && export USER_LIB_DIR="$USER_INSTALL_DIR/.local/share/dtd/lib/"
#
# if [[ -z $USER_BIN_DIR ]]; then
#   export USER_BIN_DIR="$USER_INSTALL_DIR/.local/bin"
#   export PATH="$USER_BIN_DIR:$PATH"
# fi
#

export USER_LIB_DIR="$PROJECT_ROOT_DIR/.local/share/dtd/lib/"
export USER_CONFIG_DIR="$HOME/.config/dtd"
export USER_BIN_DIR="$PROJECT_ROOT_DIR/.local/bin"
export USER_THEME_DIR="$PROJECT_ROOT_DIR/.local/dtd/themes"
export USER_CURRENT_THEME_DIR="$USER_CONFIG_DIR/current"
export PATH="$USER_BIN_DIR:$PATH"
