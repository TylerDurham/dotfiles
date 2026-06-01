#!/usr/bin/env bash

# Launch a test shell with dotfiles stowed from a given directory.
# Uses a temporary $HOME so all $HOME-relative paths resolve to the test tree.

ROOT_DIR=$(git rev-parse --show-toplevel)

LOG_LIB="$USER_LIB_DIR/bash/logger.sh"
source "$LOG_LIB" || {
  echo "FATAL: Could not load logger library '$LOG_LIB'!"
  exit 1
}

DOTFILES_DIR="$(cd "$(dirname "$0")/" && pwd)"
STOW_DIR="$DOTFILES_DIR/core"
SHELL_TYPE="${SHELL:-zsh}"
SHELL_TYPE="${SHELL_TYPE##*/}" # strip path prefix (e.g. /bin/zsh -> zsh)
SHELL_TYPE="bash"

RUN_CMD=""

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Launch a test shell with dotfiles stowed from a directory into a
temporary \$HOME, so changes can be validated without touching your
live config.

OPTIONS:
  -s, --shell <zsh|bash>   Shell to launch (default: $SHELL_TYPE)
  -d, --dir <path>         Stow directory to test (default: ./core)
  -c, --command <cmd>      Run command in the shell and exit
  -h, --help               Show this help

EXAMPLES:
  $(basename "$0")
  $(basename "$0") --shell bash
  $(basename "$0") --dir ./core
  $(basename "$0") -s zsh -d ./temp/core
  $(basename "$0") -c "echo hello"
EOF
  exit 0
}

while [[ $# -gt 0 ]]; do
  case $1 in
  -s | --shell)
    SHELL_TYPE="$2"
    shift 2
    ;;
  -d | --dir)
    STOW_DIR="$(realpath "$2")"
    shift 2
    ;;
  -c | --command)
    RUN_CMD="$2"
    shift 2
    ;;
  -h | --help) usage ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
done

if [[ ! -d "$STOW_DIR" ]]; then
  echo "Error: stow directory '$STOW_DIR' not found"
  exit 1
else
  cd "$STOW_DIR"
fi

if ! command -v stow &>/dev/null; then
  warn "'stow' is not installed!"
fi

FAKE_HOME=$(mktemp -d /tmp/$USER.XXXXXX)
cleanup() { rm -rf "$FAKE_HOME"; }
trap cleanup EXIT

echo "Launching $SHELL_TYPE  [HOME=$FAKE_HOME]"
echo "Exit the shell to clean up."
echo "---"

XDG_CONFIG_HOME=$FAKE_HOME

if [[ -n "$RUN_CMD" ]]; then
  HOME="$FAKE_HOME" \
    XDG_CONFIG_HOME="$FAKE_HOME/.config" \
    "$SHELL_TYPE" -c "$RUN_CMD" --init-file ./mock-shell.envs
else
  HOME="$FAKE_HOME" \
    XDG_CONFIG_HOME="$FAKE_HOME/.config" \
    "$SHELL_TYPE" --init-file ./mock-shell.envs
fi
