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
  printf "$(magenta DEBUG): $(dim $*)"
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
  printf "$(blue $(bold INFO)): $text"
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
  printf " - $(magenta TASK): $text\n"
}

task-section() {
  local text="$*"
  printf "$(blue $(bold SECTION)): $text\n"
}

task-warning() {
  local text="$*"
  printf " - $(yellow warning): $text"
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
  printf "$(yellow $(bold WARNING)): $text"
}
# ===========================================================================
# error() - Prints a formatted message prefixed with ERROR.
# ===========================================================================
#   USAGE: error "My Error Message"
#
#   ARGS:
#     - text: the message to display.
error() {
  local text="$*"
  printf "$(red $(bold ERROR)): $text"
}
