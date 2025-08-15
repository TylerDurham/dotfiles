#!/usr/bin/env bash

# Figure out the correct event socket path
SOCKET_PATH="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Resolve Hyprland event socket robustly
get_socket() {
  # 1) Try hyprctl option (works on recent Hyprland)
  local from_opt
  if from_opt="$(hyprctl -j getoption socket2 2>/dev/null | jq -r '.str // empty')"; then
    if [[ -n "$from_opt" && -S "$from_opt" ]]; then
      echo "$from_opt"
      return
    fi
  fi

  # 2) Standard runtime dir
  local base="${XDG_RUNTIME_DIR:-/run/user/$UID}/hypr/$HYPRLAND_INSTANCE_SIGNATURE"
  local candidate="$base/.socket2.sock"
  if [[ -S "$candidate" ]]; then
    echo "$candidate"
    return
  fi

  # 3) Legacy fallback
  candidate="/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
  echo "$candidate"
}

handle_change() {
  update_env
}

update_env() {
  source ~/.local/bin/hyprdock
}

# Initial run
update_env

SOCKET_PATH="$(get_socket)"
echo "[monitor_env.sh] listening on: $SOCKET_PATH"

# Listen for events and trigger on monitor add/remove or mode changes
socat - UNIX-CONNECT:"$SOCKET_PATH" | while read -r event_line; do
  case "$event_line" in
    monitoradded*|monitorremoved*|monitorstate*|monitorlayout*) handle_change ;;
  esac
done
