#!/bin/bash
IFACE=${1:-$(cat /proc/net/route | awk '$2 == "00000000" {print $1; exit}')}
STATFILE="/tmp/.tmux_netspeed_${IFACE}"

# 用 /proc/uptime 代替 date,少 fork 一个进程(读文件比 date 快)
read -r NOW1 _ < /proc/uptime
read -r R1 T1 < <(awk -v iface="$IFACE" '$0 ~ iface":" {gsub(iface":", ""); print $1, $9}' /proc/net/dev)

if [[ -f "$STATFILE" ]]; then
    read -r R0 T0 NOW0 < "$STATFILE"
    # 用 bash 内建算术,NOW1/NOW0 是浮点秒,转成整数毫秒近似处理
    DT_MS=$(( (${NOW1%.*}*1000 + ${NOW1#*.}) - (${NOW0%.*}*1000 + ${NOW0#*.}) ))
    [[ $DT_MS -le 0 ]] && DT_MS=1000
    RX_KB=$(( (R1 - R0) * 1000 / DT_MS / 1024 ))
    TX_KB=$(( (T1 - T0) * 1000 / DT_MS / 1024 ))
    printf 'd: %dK u: %dK' "$RX_KB" "$TX_KB"
else
    printf 'd: 0K u: 0K'
fi

echo "$R1 $T1 $NOW1" > "$STATFILE"

