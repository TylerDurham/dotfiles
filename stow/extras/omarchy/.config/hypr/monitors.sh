#!/usr/bin/env bash


# Count of monitors: 3
# Monitor: BOE 0x0BC9 
# Monitor: LG Electronics LG ULTRAWIDE 0x0001DEEC
# Monitor: LG Electronics LG ULTRAGEAR 404MXCR52499

# monitor = DP-8, 2560x1440, 0x0, 1
# monitor = DP-7, 2560x1080, 2560x0, 1
# monitor = , preferred, auto, auto

LOG_PATH=/tmp/monitors.log
MONITOR_ENVS="$HOME/.config/hypr/monitors.env"
MONITOR_COUNT=$(hyprctl monitors -j | jq '[.[] | select(.disabled == false)] | length')
LG_ULTRAWIDE="LG Electronics LG ULTRAWIDE 0x0001DEEC"
LG_ULTRAGEAR="LG Electronics LG ULTRAGEAR 404MXCR52499"

echo "Count of monitors: $MONITOR_COUNT"

# write_single_monitor() {
#   echo "monitor = , preferred, auto, auto" >> $MONITOR_ENVS
# }
#
# if (( $MONITOR_COUNT == 1)); then
#   echo "" > $MONITOR_ENVS
#   write_single_monitor
#   hyprctl reload
#   exit 0
# fi

# Fill array with monitor descriptors
mapfile -t MONITOR_DESCRIPTIONS < <(
  hyprctl monitors -j |
  jq -r '.[] | select(.disabled == false)
         | "\(.description)"'
)

# Fill array with monitor names
mapfile -t MONITOR_NAMES < <(
  hyprctl monitors -j |
  jq -r '.[].name'
)

now=$(date)

echo "# auto-generated $now" > $MONITOR_ENVS
for ((i=1; i<=MONITOR_COUNT; i++)); do
    name="${MONITOR_NAMES[i-1]}"
    description="${MONITOR_DESCRIPTIONS[i-1]}"

    if (( MONITOR_COUNT == 1 )); then
      echo "\$MONITOR_INTERNAL = $name" >> $MONITOR_ENVS
      break
    fi

    if [[ "$description" == "$LG_ULTRAWIDE" ]]; then
      echo "\$MONITOR_1 = $name" >> $MONITOR_ENVS
    elif [[ "$description" == "$LG_ULTRAGEAR" ]]; then
      echo "\$MONITOR_2 = $name" >> $MONITOR_ENVS
    else
      echo $name
    fi
      
done

echo "$now - $MONITOR_COUNT monitors now detected: ${MONITOR_NAMES[@]}" | tee -a $LOG_PATH | xargs -0 notify-send --
