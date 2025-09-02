#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  net_download.sh
#  Samples network traffic on a given interface and reports download usage
#  as a percentage (0–100) of a configured max speed.
#  
#  Usage: ./net_download.sh
#  Example: output "42" → meaning 42% of max throughput.
#
# ─────────────────────────────────────────────────────────────────────────────

iface="${NET_IFACE:-$(ip -4 -o route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++) if($i=="dev"){print $(i+1); exit}}')}"
[[ -z "${iface:-}" ]] && iface="${NET_IFACE:-$(ip -4 -o route 2>/dev/null | awk '/default/ {print $5; exit}')}"
[[ -z "${iface:-}" ]] && { echo 0; exit 0; }
max_speed="${MAX_SPEED_BYTES:-12500000}"   # 100 Mbps default; override via env

# First sample
rx1=$(awk -F'[: ]+' -v iface="$iface" '$2==iface {print $3}' /proc/net/dev)
sleep 1
# Second sample
rx2=$(awk -F'[: ]+' -v iface="$iface" '$2==iface {print $3}' /proc/net/dev)

bps=$((rx2 - rx1))              # bytes per second
percent=$((bps * 100 / max_speed))

# Clamp between 0–100
if [ "$percent" -gt 100 ]; then percent=100; fi
if [ "$percent" -lt 0 ]; then percent=0; fi

echo $percent

