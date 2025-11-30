#!/usr/bin/env bash

# ===========================================
# Tmux Status Script - Atualização 1s (CORRIGIDO)
# ===========================================

# --- Cores Tokyo Night ---
cpu_color="#7aa2f7"
mem_color="#9ece6a"
bat_color="#e0af68"
net_color="#bb9af7"
time_color="#7dcfff"

# --- CPU Usage ---
cpu_usage() {
    local cpu_line total idle
    read -r _ user nice system idle iowait irq softirq _ < <(grep '^cpu ' /proc/stat)
    total=$((user + nice + system + idle + iowait + irq + softirq))
    local prev_file="/tmp/tmux_cpu_prev"
    if [[ -f $prev_file ]]; then
        read -r prev_total prev_idle < "$prev_file"
        local diff_total=$((total - prev_total))
        local diff_idle=$((idle - prev_idle))
        [[ $diff_total -gt 0 ]] && echo $((100 * (diff_total - diff_idle) / diff_total)) || echo 0
    else
        echo 0
    fi
    echo "$total $idle" > "$prev_file"
}

# --- Memory Usage (CORRIGIDO) ---
mem_usage() {
    awk '/MemTotal:/ {total=$2} /MemAvailable:/ {available=$2} END {
        if (total > 0) {
            used = total - available
            printf "%.0f", (100 * used / total)
        } else print "0"
    }' /proc/meminfo
}

# --- Battery Level ---
battery() {
    if command -v acpi &>/dev/null; then
        acpi -b 2>/dev/null | awk -F'[,:%]' '{print $3"%"}' | head -n1
    else
        echo "N/A"
    fi
}

# --- Detecta interface de rede (MELHORADO) ---
active_iface() {
    local candidates=("wlp3s0" "wlan0" "eth0" "enp0s3")
    for iface in "${candidates[@]}"; do
        if ip link show "$iface" up &>/dev/null 2>&1; then
            echo "$iface"; return
        fi
    done
    # Qualquer interface UP (exceto virtuais)
    local iface=$(ip -o link show up | awk -F': ' '
        $2 !~ /^(lo|docker|veth|br-|vmnet|virbr)/ && $3 ~ /UP/ {print $2; exit}')
    [[ -n "$iface" ]] && echo "$iface" || echo "none"
}

# --- Network Speed (CORRIGIDO) ---
network_speed() {
    local iface rx_now tx_now rx_old tx_old dt rx_rate tx_rate
    iface=$(active_iface)
    [[ "$iface" == "none" ]] && echo "NoNet" && return

    local NET_TMP="/tmp/tmux_net_${iface}.tmp"

    rx_now=$(awk -v i="^${iface}:" '$0 ~ i {print $2}' /proc/net/dev)
    tx_now=$(awk -v i="^${iface}:" '$0 ~ i {print $10}' /proc/net/dev)

    if [[ -f "$NET_TMP" ]]; then
        read rx_old tx_old time_old < "$NET_TMP"
        dt=$(( $(date +%s) - time_old ))
        if (( dt > 0 )); then
            rx_rate=$(( (rx_now - rx_old) / 1024 / dt ))
            tx_rate=$(( (tx_now - tx_old) / 1024 / dt ))
        else
            rx_rate=0; tx_rate=0
        fi
    else
        rx_rate=0; tx_rate=0
    fi

    echo "$rx_now $tx_now $(date +%s)" > "$NET_TMP"
    printf "%d↓ %d↑ kB/s" "$rx_rate" "$tx_rate"
}

# --- Date/Time ---
datetime() {
    LC_TIME=en_US.UTF-8 date +"%a, %d %B %Y %H:%M:%S"
}

# --- Compose final line ---
cpu=$(cpu_usage)
mem=$(mem_usage)
bat=$(battery)
net=$(network_speed)
time=$(datetime)

echo "#[fg=${cpu_color}] ${cpu}%  #[fg=${mem_color}] ${mem}%  #[fg=${bat_color}] ${bat}  #[fg=${net_color}]󰖟 ${net}  #[fg=${time_color}] ${time}"
