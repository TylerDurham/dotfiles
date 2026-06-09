# #########################################################################
# ____ _  _ _  _ ____ 
# |___ |\ | |  | [__  
# |___ | \|  \/  ___] 
#
# #########################################################################

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Put Homebrew bin first so env bash finds modern version
  export PATH="$(brew --prefix)/bin:$PATH"
fi 

# TODO: Move to "my" prefix
export USER_INSTALL_DIR="$HOME/.local/share/dtd" #$(dtdconfig get env.INSTALL_DIR | envsubst)" 
export USER_BIN_DIR="$HOME/.local/bin" #$(dtdconfig get env.BIN_DIR | envsubst)"
export USER_LIB_DIR="$USER_INSTALL_DIR/lib" #$(dtdconfig get env.LIB_DIR | envsubst)"
export USER_CONFIG_DIR="$HOME/.config/dtd" #$(dtdconfig get env.CONFIG_DIR | envsubst)"
export USER_LOG_DIR="/tmp" #$(dtdconfig get env.LOG_DIR | envsubst)"
export USER_APP_DIR="$HOME/.local/share/applications" #$(dtdconfig get env.APP_DIR | envsubst)"
export USER_WALLPAPER_DIR="$HOME/Pictures/wallpapers" #$(dtdconfig get theme.WALLPAPER_DIR | envsubst)"
export USER_THEME_DIR="$USER_INSTALL_DIR/themes"
export USER_CURRENT_THEME_DIR="$USER_CONFIG_DIR/current"
mkdir -p "$USER_LOG_DIR" # Ensure log directory exists

# NOTE: New "my" prefix
export MY_BASH_LIB_DIR="$USER_LIB_DIR/bash"
export MY_BASH_LIB_DIR="$USER_LIB_DIR/bash"
export MY_BIN_DIR="$USER_BIN_DIR"
export MY_CONFIG_DIR="$USER_CONFIG_DIR"
export MY_LIB_DIR="$USER_LIB_DIR"
export MY_LOG_DIR="$USER_LOG_DIR"
export MY_WALLPAPER_DIR="$USER_WALLPAPER_DIR"
export PATH="$USER_BIN_DIR:$HOME/go/bin:/usr/local/go/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin

# # =======================================================================================
# # LOGGING
# # =======================================================================================

if [[ ! -n "${USER_ENVS_LOADED}" ]]; then
  declare -rx LOG_LEVEL_FATAL=0
  declare -rx LOG_LEVEL_ERROR=1
  declare -rx LOG_LEVEL_WARN=2
  declare -rx LOG_LEVEL_INFO=4
  declare -rx LOG_LEVEL_DEBUG=8
  declare -x LOG_TO_FILE=0
  declare -x LOG_FILE=
fi

export LOG_LEVEL=$LOG_LEVEL_INFO

# LOAD LAST
declare -rx USER_ENVS_LOADED=1 &> /dev/null

# Load Ollama envs if they are present
[ -f "$HOME/ollama.env.sh" ] && source "$HOME/ollama.env.sh"

# KVM/qemu
export LIBGUESTFS_BACKEND=direct
export LIBVIRT_DEFAULT_URI="qemu:///system"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# if [[ -n "${USER_ENVS_LOADED}" ]]; then
#     # echo "USER_ENVS already loaded by '$0'." 
#     return 0
# fi
#
# declare -rx USER_ENVS_LOADED=1
# # =======================================================================================
# # PATHS
# # =======================================================================================
#
# declare -rx USER_PREFIX="dtd"
#
# locate_install_dir() {
#   local root=$(find ~/.local/share -type l -name "$USER_PREFIX")
#   echo "$root"
# }
#
# declare -rx USER_INSTALL_DIR="$HOME/.local/share/$USER_PREFIX" #$(locate_install_dir)
# declare -rx USER_CONFIG_DIR="$HOME/.config/"$USER_PREFIX
# declare -rx USER_BIN_DIR="$USER_INSTALL_DIR/bin"
# declare -rx USER_LIB_DIR="$USER_INSTALL_DIR/lib"
# declare -rx USER_APP_DIR="$HOME/.local/$USER_PREFIX/share/applications"
# declare -rx USER_THEMES_DIR="$HOME/.config/$USER_PREFIX/themes"
# declare -rx USER_LOG_DIR="/tmp/@"$USER_PREFIX"_$USER"
# mkdir -p "$USER_LOG_DIR" # Ensure log directory exists
#
# # =======================================================================================
# # LOGGING
# # =======================================================================================
#
# declare -rx LOG_LEVEL_FATAL=0
# declare -rx LOG_LEVEL_ERROR=1
# declare -rx LOG_LEVEL_WARN=2
# declare -rx LOG_LEVEL_INFO=4
# declare -rx LOG_LEVEL_DEBUG=8
#
# declare -A LOG_LEVELS=(
#   [FATAL]=$LOG_LEVEL_FATAL
#   [ERROR]=$LOG_LEVEL_ERROR
#   [WARN]=$LOG_LEVEL_WARN
#   [INFO]=$LOG_LEVEL_INFO
#   [DEBUG]=$LOG_LEVEL_DEBUG
#  )
#
# declare -A LOG_LEVELS_REV=(
#   [$LOG_LEVEL_FATAL]=FATAL
#   [$LOG_LEVEL_ERROR]=ERROR
#   [$LOG_LEVEL_WARN]=WARN
#   [$LOG_LEVEL_INFO]=INFO
#   [$LOG_LEVEL_DEBUG]=DEBUG
# )
#
# # NodeJS
# [ -d "$HOME/.nvm" ] && export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# # Python - UV
# [ -s "$HOME/.local/bin/env" ] && \. "$HOME/.local/bin/env"
#
# # Bun
# [ -d ~/.bun/bin ] && export PATH=$PATH:~/.bun/bin
#
# export PATH="$USER_BIN_DIR":$PATH
#
# # =======================================================================================
# # MISC.
# # =======================================================================================
#
# # Set for running sysprep on KVM
# export LIBGUESTFS_BACKEND=direct
# # User-specific settings file that is NOT checked into source code control.
#
# declare -rx USER_USER_SETTINGS="$HOME"/"$USER_PREFIX"_user_settings.env
# if [ -f "$USER_USER_SETTINGS" ]; then
#   source "$USER_USER_SETTINGS" ]
# else 
#   echo "export LOG_LEVEL=\$LOG_LEVEL_INFO" > $USER_USER_SETTINGS
#   echo "wallpaper=" >> $USER_USER_SETTINGS
# fi

