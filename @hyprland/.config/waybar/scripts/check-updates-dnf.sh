#!/usr/bin/bash
#  ______       _                 
#  |  ___|     | |                
#  | |_ ___  __| | ___  _ __ __ _ 
#  |  _/ _ \/ _` |/ _ \| '__/ _` |
#  | ||  __/ (_| | (_) | | | (_| |
#  \_| \___|\__,_|\___/|_|  \__,_|
#  
# =========================================== 
#  check-updates-dnf.sh                                 
# =========================================== 
# Get the count of updates, as well as security updates.
# NOTE: This only works on Fedora.
all_updates=$(dnf check-update --quiet | wc -l)
sec_updates=$(dnf check-update --security --quiet | wc -l)

LOW_THRESHOLD=0
LOW_THRESHOLD_CLASS="low"
MED_THRESHOLD=30
MED_THRESHOLD_CLASS="medium"
MAX_THRESHOLD=100
MAX_THRESHOLD_CLASS="max"

# Uncomment to test without calling check-update
#all_updates=0
#sec_updates=0

if [[ "$all_updates" -eq "$LOW_THRESHOLD" ]]; then
  tooltip="No updates at this time."
  cssclass=$LOW_THRESHOLD_CLASS

elif [[ $all_updates -ge $MED_THRESHOLD && $all_updates -lt $MAX_THRESHOLD ]]; then
  tooltip="$all_updates update(s) available. Click to update."
  cssclass=$MED_THRESHOLD_CLASS

elif [[ $all_updates -ge $MAX_THRESHOLD ]]; then
  tooltip="$all_updates update(s) available. Click to update."
  cssclass=$MAX_THRESHOLD_CLASS
fi

# Do we have security updates?
if [[ $sec_updates -gt 0 ]]; then
  tooltip="$all_updates update(s) available, include $sec_updates security update(s). Click to update."
  cssclass=$MAX_THRESHOLD_CLASS
fi

#printf '{ "text": "%s", "alt": "%s", "toolip": "test %s", "class": "%s" }' "$all_updates" "$all_updates" "$tooltip" "$cssclass"

echo "{ \"text\": \"$all_updates\", \"tooltip\": \"$tooltip\", \"class\": \"$cssclass\" }"

