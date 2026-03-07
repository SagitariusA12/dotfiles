#!/usr/bin/env bash
# =============================================================
# ~/.tmux/scripts/tmux-status.sh — Tokyo Night Status Bar
# =============================================================

# ── Paleta Tokyo Night ────────────────────────────────────────
C_BLUE="#7aa2f7"
C_GREEN="#9ece6a"
C_YELLOW="#e0af68"
C_RED="#f7768e"
C_PURPLE="#bb9af7"
C_CYAN="#7dcfff"
C_GRAY="#565f89"
C_FG="#c0caf5"

# ── Cor por threshold ─────────────────────────────────────────
threshold_color() {
  local val=$1 warn=$2 crit=$3
  if   (( val >= crit )); then echo "$C_RED"
  elif (( val >= warn )); then echo "$C_YELLOW"
  else echo "$C_GREEN"
  fi
}

# ── Formata bytes/s ───────────────────────────────────────────
fmt_speed() {
  local kb=$1
  if   (( kb >= 10240 )); then printf "%.1fMB" "$(awk "BEGIN{printf \"%.1f\",$kb/1024}")"
  elif (( kb >= 1024  )); then printf "%.0fMB" "$(awk "BEGIN{printf \"%.0f\",$kb/1024}")"
  else printf "%dkB" "$kb"
  fi
}

# ── CPU ───────────────────────────────────────────────────────
cpu_usage() {
  local prev_file="/tmp/tmux_cpu_prev"
  read -r _ user nice system idle iowait irq softirq _ < <(grep '^cpu ' /proc/stat)
  local total=$(( user + nice + system + idle + iowait + irq + softirq ))

  local pct=0
  if [[ -f $prev_file ]]; then
    read -r prev_total prev_idle < "$prev_file"
    local diff_total=$(( total - prev_total ))
    local diff_idle=$(( idle  - prev_idle  ))
    (( diff_total > 0 )) && pct=$(( 100 * (diff_total - diff_idle) / diff_total ))
  fi
  printf "%d %d" "$total" "$idle" > "$prev_file"

  local color; color=$(threshold_color "$pct" 60 85)
  printf "#[fg=${C_FG}]󰻠 #[fg=${color}]%d%%#[fg=${C_FG}]" "$pct"
}

# ── RAM ───────────────────────────────────────────────────────
mem_usage() {
  read -r pct used_gb <<< "$(awk '
    /MemTotal:/     {total=$2}
    /MemAvailable:/ {avail=$2}
    END {
      used = total - avail
      pct  = (total > 0) ? int(100 * used / total) : 0
      printf "%d %.1f", pct, used/1048576
    }' /proc/meminfo)"

  local color; color=$(threshold_color "$pct" 60 85)
  printf "#[fg=${C_FG}]󰍛 #[fg=${color}]%sG#[fg=${C_FG}]" "$used_gb"
}

# ── Bateria ───────────────────────────────────────────────────
battery() {
  local bat_dir
  bat_dir=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -1)

  if [[ -n "$bat_dir" ]]; then
    local pct status
    pct=$(cat "$bat_dir/capacity" 2>/dev/null) || return
    status=$(cat "$bat_dir/status" 2>/dev/null)

    local icon color
    if [[ "$status" == "Charging" ]]; then
      icon="󰂄"; color="$C_GREEN"
    elif (( pct >= 80 )); then icon="󰁹"; color="$C_GREEN"
    elif (( pct >= 40 )); then icon="󰁾"; color="$C_YELLOW"
    elif (( pct >= 15 )); then icon="󰁼"; color="$C_YELLOW"
    else                        icon="󰁺"; color="$C_RED"
    fi
    printf "#[fg=${color}]%s %d%%#[fg=${C_FG}]" "$icon" "$pct"

  elif command -v acpi &>/dev/null; then
    local out; out=$(acpi -b 2>/dev/null | head -1)
    local pct; pct=$(echo "$out" | grep -oP '\d+(?=%)')
    local icon color
    if [[ "$out" == *Charging* ]]; then icon="󰂄"; color="$C_GREEN"
    elif (( pct >= 40 ));              then icon="󰁾"; color="$C_YELLOW"
    else                                    icon="󰁺"; color="$C_RED"
    fi
    printf "#[fg=${color}]%s %d%%#[fg=${C_FG}]" "$icon" "$pct"
  fi
}

# ── Rede ──────────────────────────────────────────────────────
network_speed() {
  local iface
  iface=$(ip route show default 2>/dev/null | awk 'NR==1{print $5}')
  [[ -z "$iface" ]] && printf "#[fg=${C_GRAY}]󰖪 offline#[fg=${C_FG}]" && return

  local NET_TMP="/tmp/tmux_net_${iface}.tmp"
  local rx_now tx_now
  rx_now=$(awk -v dev="${iface}:" '$1==dev{print $2}'  /proc/net/dev)
  tx_now=$(awk -v dev="${iface}:" '$1==dev{print $10}' /proc/net/dev)

  local rx_rate=0 tx_rate=0
  if [[ -f "$NET_TMP" ]]; then
    read -r rx_old tx_old time_old < "$NET_TMP"
    local dt=$(( $(date +%s) - time_old ))
    if (( dt > 0 )); then
      rx_rate=$(( (rx_now - rx_old) / 1024 / dt ))
      tx_rate=$(( (tx_now - tx_old) / 1024 / dt ))
    fi
  fi
  printf "%d %d %d" "$rx_now" "$tx_now" "$(date +%s)" > "$NET_TMP"

  printf "#[fg=${C_CYAN}]󰖩 #[fg=${C_FG}]%s↓ %s↑" "$(fmt_speed $rx_rate)" "$(fmt_speed $tx_rate)"
}

# ── Data e Hora ───────────────────────────────────────────────
datetime() {
  printf "#[fg=${C_PURPLE}]󰃰 #[fg=${C_FG}]%s  #[fg=${C_BLUE}]%s#[fg=${C_FG}]" \
    "$(LC_TIME=en_US.UTF-8 date '+%a %d/%m')" \
    "$(date '+%H:%M:%S')"
}

# ── Separador ─────────────────────────────────────────────────
SEP=" #[fg=${C_GRAY}]│#[fg=${C_FG}] "

# ── Monta a barra ─────────────────────────────────────────────
parts=()
bat=$(battery)
[[ -n "$bat" ]] && parts+=("$bat")
parts+=("$(cpu_usage)")
parts+=("$(mem_usage)")
parts+=("$(network_speed)")
parts+=("$(datetime)")

bar=""
for i in "${!parts[@]}"; do
  (( i > 0 )) && bar+="$SEP"
  bar+="${parts[$i]}"
done

printf " %s " "$bar"
