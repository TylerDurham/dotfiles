#!/usr/bin/env bash

# Launch a 'mock' test shell with dotfiles stowed from a given directory.
# Uses a temporary $HOME so all $HOME-relative paths resolve to the test tree.

ROOT_DIR=$(git rev-parse --show-toplevel)

LOG_LIB="$USER_LIB_DIR/bash/logger.sh"
source "$LOG_LIB" || {
  echo "FATAL: Could not load logger library '$LOG_LIB'!"
  exit 1
}

SHELL_TYPE="${SHELL:-zsh}"
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

touch "$FAKE_HOME/.bashrc"

if [[ -n "$RUN_CMD" ]]; then
  HOME="$FAKE_HOME" \
    XDG_CONFIG_HOME="$FAKE_HOME/.config" \
    "$SHELL_TYPE" -c "$RUN_CMD" --init-file ./mock-shell.envs
else
  HOME="$FAKE_HOME" \
    XDG_CONFIG_HOME="$FAKE_HOME/.config" \
    "$SHELL_TYPE" --init-file ./mock-shell.envs
fi
