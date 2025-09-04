#!/bin/bash

#usage: displayshift.sh [light|temp] [0-9]+
#light range: 1-100
#color range: 1000-25000

#--settings--

#notification icons (defaults are in papirus-icon-theme)
icolight="notification-display-brightness-medium"
icotemp="colortone"
icotemp_default="emblem-default" #shown when color temperature is exactly 6500 (default)

#cache location / files
cachefol="$HOME/.cache/displayshift"
cachelight="$cachefol/backlight.dat"
cachetemp="$cachefol/colortemp.dat"
cachenotid="$cachefol/notify.dat"

#--functions--

to_int() { [[ "$1" =~ ^[\-]?[0-9]+$ ]] && echo "$1" || echo 0; }
msg_err() { notify-send -i dialog-error "displayshift" "$@"; }
msg_light() { notify-send -i $icolight -h int:value:$newlight -r "$notid" -p " "; }

msg_temp() {
  tempico="$icotemp"
  [[ "$newtemp" = "6500" ]] && tempico="$icotemp_default"
  notify-send -i $tempico -h int:value:$((newtemp * 4 / 1000)) -r "$notid" -p " "
}

#--main--

[[ -d "$cachefol" ]] || mkdir "$cachefol" || (
  msg_err "err: failed to create cache folder"
  exit
)

#read params
case "$1" in
light)
  chnglight="$2"
  chngtemp=0
  ;;
temp)
  chnglight=0
  chngtemp="$2"
  ;;
*)
  msg_err "err: invalid parameter"
  exit
  ;;
esac
chnglight="$(to_int "$chnglight")"
chngtemp="$(to_int "$chngtemp")"

#read cache data
if [[ -f "$cachenotid" ]]; then
  notid="$(cat "$cachenotid")"
else notid=0; fi
notid="$(to_int "$notid")"

if [[ -f "$cachelight" ]]; then
  curlight="$(cat "$cachelight")"
  [[ "${curlight:0:1}" = "0" ]] && curlight="${curlight:1}"
else curlight=100; fi
curlight="$(to_int "$curlight")"

if [[ -f "$cachetemp" ]]; then
  curtemp="$(cat "$cachetemp")"
else curtemp=6500; fi
curtemp="$(to_int "$curtemp")"

#calculate new, ensure within valid range
newlight="$((curlight + chnglight))"
[[ "$newlight" -lt 1 ]] && newlight=1
[[ "$newlight" -gt 100 ]] && newlight=100
[[ "$newlight" -lt 100 ]] && newlight="0$newlight"
[[ "$curlight" -lt 100 ]] && curlight="0$curlight"

newtemp="$((curtemp + chngtemp))"
[[ "$newtemp" -lt 1000 ]] && newtemp=1000
[[ "$newtemp" -gt 25000 ]] && newtemp=25000

#make changes (if needed)
if { [[ "$1" = "light" ]] && [[ ! "$newlight" = "$curlight" ]]; } ||
  { [[ "$1" = "temp" ]] && [[ ! "$newtemp" = "$curtemp" ]]; }; then

  if redshift -P -O $newtemp -b ${newlight:0:1}.${newlight:1:1}:${newlight:0:1}.${newlight:1:1}; then
    case $1 in
    light) echo "$newlight" >"$cachelight" ;;
    temp) echo "$newtemp" >"$cachetemp" ;;
    esac
  else
    msg_red "err: failed to run redshift with specified value"
    exit
  fi

fi

#final notification
case $1 in
light) msg_light >"$cachenotid" ;;
temp) msg_temp >"$cachenotid" ;;
esac
