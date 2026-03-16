#!/usr/bin/env bash

STATE_FILE="$HOME/.config/sketchybar/.transparency_state"

# Read current state
if [ -f "$STATE_FILE" ]; then
  CURRENT_STATE=$(cat "$STATE_FILE")
else
  CURRENT_STATE="on"
fi

# Toggle state
if [ "$CURRENT_STATE" = "on" ]; then
  NEW_STATE="off"
  # Disable transparency
  yabai -m config active_window_opacity 1.00
  yabai -m config normal_window_opacity 1.00
else
  NEW_STATE="on"
  # Enable transparency
  yabai -m config active_window_opacity 0.90
  yabai -m config normal_window_opacity 0.80
fi

# Save new state
echo "$NEW_STATE" > "$STATE_FILE"

# Trigger sketchybar update
sketchybar --trigger transparency_change INFO="$NEW_STATE"
