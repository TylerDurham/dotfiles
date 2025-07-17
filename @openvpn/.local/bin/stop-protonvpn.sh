#!/bin/bash

PIDFILE="$HOME/.config/openvpn/protonvpn.pid"

if [[ -f "$PIDFILE" ]]; then
  PID=$(cat "$PIDFILE")
  notify-send "Stopping Proton VPN (PID $PID)..."
  sudo kill -2 "$PID"
  rm "$PIDFILE"
  notify-send "Proton VPN stopped."
else
  notify-send "No PID file found. Is the VPN running?"
fi
