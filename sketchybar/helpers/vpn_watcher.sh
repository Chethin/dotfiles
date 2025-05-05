#!/bin/bash

STATE_FILE="/tmp/.vpn_state"

get_vpn_name() {
  scutil --nc list | grep Connected | sed -E 's/.*"(.+)".*/\1/'
}

while true; do
  current_vpn="$(get_vpn_name)"
  previous_vpn=""

  if [[ -f "$STATE_FILE" ]]; then
    previous_vpn=$(<"$STATE_FILE")
  fi

  if [[ "$current_vpn" != "$previous_vpn" ]]; then
    echo "$current_vpn" > "$STATE_FILE"
    sketchybar --trigger vpn_update
  fi

  sleep 10
done