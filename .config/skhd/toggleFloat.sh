#!/usr/bin/env bash

# Toggle floating state
yabai -m window --toggle float

# Resize and move window
yabai -m window --move abs:140:140
sleep 0.02
yabai -m window --resize abs:1200:700
