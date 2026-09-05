#!/usr/bin/env bash

DEVICE="ugtablet-6-inch-pentablet-pen"
MON_A="eDP-1"
MON_B="HDMI-A-1"
STATE_FILE="/tmp/tablet_output_state"

# Lê o último estado salvo, ou assume MON_A se não existir
current=$(cat "$STATE_FILE" 2>/dev/null || echo "$MON_A")

if [ "$current" = "$MON_A" ]; then
  next="$MON_B"
else
  next="$MON_A"
fi

hyprctl keyword "device[$DEVICE]:output" "$next"
echo "$next" > "$STATE_FILE"
notify-send "Tablet mapeada" "$next"
