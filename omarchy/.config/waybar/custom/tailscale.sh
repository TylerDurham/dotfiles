#!/usr/bin/env bash

STATE=$(tailscale status --json 2>/dev/null | jq -r '.BackendState // "Stopped"')
PEERCOUNT=$(tailscale status --json 2>/dev/null | jq '.Peer | length' 2>/dev/null)

if [[ "$1" == "toggle" ]]; then
  echo "Current status: '$STATE'"
  echo "Ensure sudo tailscale set --operator=$USER has been run at least once!"

  if [[ "$STATE" == "Running" ]]; then
    echo "Shutting down tailscale..."
    tailscale down
    notify-send "Tailscale" "Tailscale has been shutdown."
  else
    echo "Starting up tailscale..."
    tailscale up # --qr=false --accept-routes
    notify-send "Tailscale" "Tailscale has been started."
  fi

  exit 0
fi

ICON=""   # fallback
CLASS="error"
TIP="Tailscale: unavailable"

case "$STATE" in
  Running)
    ICON=""   # lock icon in UTF-8
    CLASS="connected"
    TIP="Tailscale: Connected\nPeers: ${PEERCOUNT:-0}"
    ;;
  Stopped|"")
    ICON=""
    CLASS="disconnected"
    TIP="Tailscale: Disconnected"
    ;;
  Starting)
    ICON=""
    CLASS="starting"
    TIP="Tailscale: Starting up..."
    ;;
esac

# Output valid JSON with raw UTF-8 (not \u{XXXX})
printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' \
  "$ICON" "$CLASS" "$TIP"
