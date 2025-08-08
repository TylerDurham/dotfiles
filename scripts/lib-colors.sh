# ##############################
# ____ ____ _    ____ ____ ____
# |    |  | |    |  | |__/ [__
# |___ |__| |___ |__| |  \ ___]
#
# ##############################

bg-blue() { echo -e "\033[44m$*\033[0m"; }
bg-green() { echo -e "\033[42m$*\033[0m"; }
bg-red() { echo -e "\033[41m$*\033[0m"; }
bg-yellow() { echo -e "\033[43m$*\033[0m"; }
bg-magenta() { echo -e "\033[45m$*\033[0m"; }

black() {
  echo -e "\033[30m$*\033[0m"
}

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
# debug() - echos a formatted message prefixed with DEBUG.
# ===========================================================================
#   USAGE: debug "My Debug Message"
#
#   ARGS:
#     - text: the message to display.
debug() {
  printf "$(magenta DEBUG): $(dim $*)\n"
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
  printf "$(red $(bold ERROR)): $text\n"
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
  printf "$(green $(bold INFO)): $text\n"
}

# ===========================================================================
# task() - Prints a formatted message prefixed with TASK.
# ===========================================================================
#   USAGE: task "My Task Message"
#
#   REMARKS: Should follow calls to task-list.
#
#   ARGS:
#     - text: the message to display.
task() {
  local text="$*"
  printf "$(blue $(bold TASK)): $text\n"
}

# ===========================================================================
# task-list() - Prints a formatted message prefixed with TASKS.
# ===========================================================================
#
#   REMARKS: Begins a task section or group. Follow with calls to subtask for
#            a list of formatted subtasks.
#
#   USAGE: task-list "My Task Message"
#
#   ARGS:
#     - text: the message to display.
task-list() {
  local text="$*"
  printf "$(blue $(bold TASKS)): $text\n"
}

suberror() {
  local text="$*"
  printf " - $(error $text)\n"
}

subinfo() {
  local text="$*"
  printf " - $(info $text)\n"
}

subdebug() {
  local text="$*"
  printf " - $(debug $text)\n"
}

subtask() {
  local text="$*"
  printf " - $(task $text)\n"
}

subwarning() {
  local text="$*"
  printf " - $(warning $text)\n"
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
  printf "$(yellow $(bold WARNING)): $text\n"
}
