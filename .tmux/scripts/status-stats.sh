#!/usr/bin/env bash
# Prints CPU% / free memory / free disk for the tmux status bar.

read -r _ a b c d _ < /proc/stat
t1=$((a + b + c + d))
i1=$d
sleep 0.2
read -r _ a b c d _ < /proc/stat
t2=$((a + b + c + d))
i2=$d
dt=$((t2 - t1))
(( dt > 0 )) && cpu=$(( 100 - (i2 - i1) * 100 / dt )) || cpu=0

mem=$(free -h --si | awk '/^Mem:/ {print $7}')
disk=$(df -h / | awk 'NR==2 {print $4}')

printf 'CPU %d%%  MEM %s  DISK %s' "$cpu" "$mem" "$disk"
