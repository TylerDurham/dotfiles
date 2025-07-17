#!/bin/bash

CONFIG="$HOME/.config/openvpn/us.protonvpn.udp.ovpn"
LOGFILE="$HOME/.config/openvpn/protonvpn.log"
PIDFILE="$HOME/.config/openvpn/protonvpn.pid"

echo "Starting Proton VPN..."
sudo -A nohup openvpn --config "$CONFIG" >"$LOGFILE" 2>&1 &
echo $! >"$PIDFILE"

notify-send "Proton VPN started with PID $(cat "$PIDFILE")"
echo "Logs: $LOGFILE"
