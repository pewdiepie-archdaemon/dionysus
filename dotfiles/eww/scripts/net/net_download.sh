#!/usr/bin/env bash
# net_download.sh — outputs % of max speed (0–100)

iface="wlp4s0"   # Wi-Fi interface
max_speed=12500000   # adjust: this is 100 Mbps (100*1e6 / 8)

# First sample
rx1=$(awk -v iface=$iface '$1 ~ iface {gsub(":", "", $1); print $2}' /proc/net/dev)
sleep 1
# Second sample
rx2=$(awk -v iface=$iface '$1 ~ iface {gsub(":", "", $1); print $2}' /proc/net/dev)

bps=$((rx2 - rx1))              # bytes per second
percent=$((bps * 100 / max_speed))

# Clamp between 0–100
if [ "$percent" -gt 100 ]; then percent=100; fi
if [ "$percent" -lt 0 ]; then percent=0; fi

echo $percent

