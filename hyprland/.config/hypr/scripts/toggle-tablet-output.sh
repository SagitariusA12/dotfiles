#!/usr/bin/env bash
set -u

DEVICE="ugtablet-6-inch-pentablet-pen"
MONITORS=("eDP-1" "HDMI-A-1")
STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/tablet_output_state"

fail() {
  notify-send -u critical "Tablet: falha" "$1"
  echo "$1" >&2
  exit 1
}

command -v hyprctl >/dev/null || fail "hyprctl não encontrado"

current=$(cat "$STATE_FILE" 2>/dev/null || true)

connected=$(hyprctl monitors -j 2>/dev/null | grep -o '"name": *"[^"]*"' | cut -d'"' -f4)
available=()
for m in "${MONITORS[@]}"; do
  grep -qx "$m" <<< "$connected" && available+=("$m")
done

[ "${#available[@]}" -eq 0 ] && fail "Nenhum monitor disponível"

next="${available[0]}"
for i in "${!available[@]}"; do
  if [ "${available[$i]}" = "$current" ]; then
    next="${available[$(( (i + 1) % ${#available[@]} ))]}"
    break
  fi
done

out=$(hyprctl eval "hl.device({ name = \"$DEVICE\", output = \"$next\" })" 2>&1)

if [ "$out" = "ok" ]; then
  echo "$next" > "$STATE_FILE"
  notify-send "Tablet mapeada" "$next"
else
  fail "$out"
fi
