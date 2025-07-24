# Default values
NO_STOW=false
NO_PACKAGES=false

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
  --no-stow)
    NO_STOW=true
    shift
    ;;
  --no-packages)
    NO_PACKAGES=true
    shift
    ;;
  --verbose | -v)
    VERBOSE=true
    shift
    ;;
  --) # end of options
    shift
    break
    ;;
  -*)
    echo "Unknown option: $1" >&2
    exit 1
    ;;
  *)
    break
    ;;
  esac
done

# ===========================================================================
# blue() - echos a formatted message in blue.
# ===========================================================================
#   USAGE: blue "My Text Message"
#
#   ARGS:
#     - text: the message to display.
blue() {
  echo -e "\033[34m$*\033[0m"
}

# ===========================================================================
# magenta() - echos a formatted message in magenta.
# ===========================================================================
#   USAGE: magenta "My Text Message"
#
#   ARGS:
#     - text: the message to display.
magenta() {
  echo -e "\033[35m$*\033[0m"
}

# ===========================================================================
# green() - echos a formatted message in green.
# ===========================================================================
#   USAGE: green "My Text Message"
#
#   ARGS:
#     - text: the message to display.
green() {
  echo -e "\033[32m$*\033[0m"
}

# ===========================================================================
# yellow() - echos a formatted message in yellow.
# ===========================================================================
#   USAGE: yellow "My Text Message"
#
#   ARGS:
#     - text: the message to display.
yellow() {
  echo -e "\033[33m$*\033[0m"
}

# ===========================================================================
# red() - echos a formatted message in red.
# ===========================================================================
#   USAGE: red "My Text Message"
#
#   ARGS:
#     - text: the message to display.
red() {
  echo -e "\033[31m$*\033[0m"
}

# ===========================================================================
# bold() - echos a formatted message in bold.
# ===========================================================================
#   USAGE: bold "My Text Message"
#
#   ARGS:
#     - text: the message to display.
bold() {
  echo -e "\033[1m$*\033[0m"
}

# ===========================================================================
# dim() - echos a formatted message, dimmed.
# ===========================================================================
#   USAGE: dim "My Text Message"
#
#   ARGS:
#     - text: the message to display.
dim() {
  echo -e "\033[2m$*\033[0m"
}
# ===========================================================================
# debug() - echos a formatted message prefixed with DEBUG.
# ===========================================================================
#   USAGE: debug "My Debug Message"
#
#   ARGS:
#     - text: the message to display.

debug() {
  echo "$(magenta DEBUG): $(dim $*)"
}

# ===========================================================================
# info() - echos a formatted message prefixed with INFO.
# ===========================================================================
#   USAGE: info "My Info Message"
#
#   ARGS:
#     - text: the message to display.
info() {
  local text="$*"
  echo "$(blue $(bold INFO)): $text"
}

# ===========================================================================
# task() - Prints a formatted message prefixed with TASK.
# ===========================================================================
#   USAGE: task "My Task Message"
#
#   ARGS:
#     - text: the message to display.
task() {
  local text="$*"
  echo "$(blue $(bold TASK)): $text"
}

# ===========================================================================
# warning() - Prints a formatted message prefixed with WARNING.
# ===========================================================================
#   USAGE: warning "My Text Message"
#
#   ARGS:
#     - text: the message to display.
warning() {
  local text="$*"
  echo "$(yellow $(bold WARNING)): $text"
}

install_package() {
  local FULL_CMD="$*"

  if [[ "$NO_PACKAGES" == false ]]; then
    echo -e "\t"$(task "Running command '$(green $FULL_CMD)'.")
    eval "$FULL_CMD"
  fi
}

stow_package() {
  local BASE_DIR="$1"
  local DIR_NAME="$2"

  # Example action (replace with your command)
  # echo "Running stow for $dirname"
  if [[ "$NO_STOW" == false ]]; then
    stow "$DIR_NAME" -d "$BASE_DIR" -t ~/
    echo -e "\t"$(task "Stowing module: '$(green $DIR_NAME)'.")
  fi

}

stow_packages() {

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
    dir_name=$(basename "$dir")

    stow_package $BASE_DIR $dir_name

  done
}
