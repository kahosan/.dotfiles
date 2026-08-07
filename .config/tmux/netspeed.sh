#!/bin/bash

IFACE=${1:-$(ip route show default | awk '{print $5; exit}')}
STATFILE="/tmp/.tmux_netspeed_${IFACE}"
read -r NOW1 _ < /proc/uptime
read -r R1 T1 < <(awk -v iface="$IFACE" '$0 ~ iface":" {gsub(iface":", ""); print $1, $9}' /proc/net/dev)

int1=${NOW1%.*}; dec1=${NOW1#*.}; dec1=$((10#$dec1))

fmt_speed() {
    awk -v kb="$1" 'BEGIN {
        if (kb >= 1024) {
            printf "%.2fM", kb/1024
        } else {
            printf "%dK", kb
        }
    }'
}

if [[ -f "$STATFILE" ]]; then
    read -r R0 T0 NOW0 < "$STATFILE"
    int0=${NOW0%.*}; dec0=${NOW0#*.}; dec0=$((10#$dec0))
    DT_MS=$(( (int1*1000 + dec1*10) - (int0*1000 + dec0*10) ))
    [[ $DT_MS -le 0 ]] && DT_MS=1000

    RX_KB=$(( (R1 - R0) * 1000 / DT_MS / 1024 ))
    TX_KB=$(( (T1 - T0) * 1000 / DT_MS / 1024 ))

    RX_STR=$(fmt_speed "$RX_KB")
    TX_STR=$(fmt_speed "$TX_KB")
    printf 'd: %s u: %s' "$RX_STR" "$TX_STR"
else
    printf 'd: 0K u: 0K'
fi

echo "$R1 $T1 $NOW1" > "$STATFILE"

