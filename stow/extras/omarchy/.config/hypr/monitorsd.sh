#!/usr/bin/env bash

set -Eeuo pipefail

# Optional: rename the process in ps/top (Linux bash supports exec -a)
[ -z "${_MONITORSD_NAMED:-}" ] && { _MONITORSD_NAMED=1 exec -a monitorsd "$0" "$@"; }

# Logging helper
#
# Function: log()
# Purpose : Logging helper. Prints output with a date prefix to both STDERR and LOGFILE.
# Args    : $* - All arguments will be printed to STDERR and LOG_FILE.
# Returns : 0 on success, non-zero on error
LOG_FILE="${HOME}/.config/hypr/monitors.log"
log() { printf '%s - [$0] %s\n' "$(date '+%F %T')" "$*" | tee -a "$LOG_FILE" >&2; }

# Single-instance lock (per-user, no sudo needed)
LOCK_BASE="${XDG_RUNTIME_DIR:-/run/user/$UID}"
if [[ ! -d "$LOCK_BASE" || ! -w "$LOCK_BASE" ]]; then
  LOCK_BASE="${HOME}/.cache"
fi

LOCK_DIR="$LOCK_BASE/$0"
mkdir -p -m 700 "$LOCK_DIR"
LOCK_FILE="$LOCK_DIR/lock"

# Acquire the lock
exec {LOCK_FD}> "$LOCK_FILE" || { log "Cannot open lock file: $LOCK_FILE"; exit 1; }
if ! flock -n "$LOCK_FD"; then
  log "Another instance is already running (lock: $LOCK_FILE). Exiting."
  exit 0
fi

# Function: cleanup() 
# Purpose : Called when the script is shutdown. Performs cleanup of logs, locks, etc.
# Args    : None
# Returns : 0 on success, non-zero on error
cleanup() {
  # Closing LOCK_FD releases the lock automatically.
  # Remove the file only if we’re in ~/.cache (runtime dirs clean themselves).
  if [[ "$LOCK_BASE" == "$HOME/.cache" ]]; then
    rm -f "$LOCK_FILE" 2>/dev/null || true
  fi
  log "Cleaning up lock file and exiting."
}
trap cleanup INT TERM EXIT # Call cleanup when script is shutdown.

# Function: get_hypr_socket() 
# Purpose : Resolve Hyprland event socket robustly
# Args    : None.
# Returns : 0 on success, non-zero on error
get_hypr_socket() {
  # 1) Try hyprctl option (works on recent Hyprland)
  local from_opt
  if from_opt="$(hyprctl -j getoption socket2 2>/dev/null | jq -r '.str // empty')" 2>/dev/null; then
    if [[ -n "$from_opt" && -S "$from_opt" ]]; then
      echo "$from_opt"
      return
    fi
  fi

  # 2) Standard runtime dir
  local base="${XDG_RUNTIME_DIR:-/run/user/$UID}/hypr/${HYPRLAND_INSTANCE_SIGNATURE:-}"
  local candidate="$base/.socket2.sock"
  if [[ -S "$candidate" ]]; then
    echo "$candidate"
    return
  fi

  # 3) Legacy fallback
  candidate="/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE:-}/.socket2.sock"
  echo "$candidate"
}

# Function: handle_change
# Purpose : Called when the hyprland socket loop gets a message.
# Args    : None.
# Returns : 0 on success, non-zero on error
handle_change() {
  update_env
}

# -----------------------------------------------------------------------------
# Function: update_env
# Purpose : Reload Hyprland monitor environment variables by sourcing
#           ~/.config/hypr/monitors.sh
#
# Arguments:
#   None
#
# Returns:
#   Always 0 (unless `monitors.sh` fails)
#
# Outputs:
#   stdout  - Any echo/printf from monitors.sh
#   stderr  - Error messages from monitors.sh (if any)
#
# Side Effects:
#   - Sources ~/.config/hypr/monitors.sh into the current shell
#   - Updates exported environment variables
#
# Example:
#   update_env
#
# Notes:
#   - Because the script is sourced, any syntax errors inside monitors.sh
#     will cause this function to fail.
# -----------------------------------------------------------------------------
update_env() {
  # Idempotent env update
  # shellcheck disable=SC1090
  source "${HOME}/.config/hypr/monitors.sh"
  log "Environment updated via monitors.sh"
}

# ----- Main
SOCKET_PATH="$(get_hypr_socket)"
if [[ ! -S "$SOCKET_PATH" ]]; then
  log "Socket not found: $SOCKET_PATH"
  exit 1
fi
log "Listening on: $SOCKET_PATH"
log "Script starting..."

# Initial scan of montors using external script.
update_env

# Keep while-loop in the main shell using process substitution
# -> exactly: 1 bash (this script) + 1 socat child
while IFS= read -r event_line; do
  case "$event_line" in
    monitoradded*|monitorremoved*|monitorstate*|monitorlayout*)
      log "Event: $event_line"
      handle_change
      ;;
  esac
done < <(socat -u - UNIX-CONNECT:"$SOCKET_PATH")
