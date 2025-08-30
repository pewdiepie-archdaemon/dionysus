#!/bin/bash
# ── vpn-toggle.sh ─────────────────────────────────────────
# Description: Toggle VPN on/off via systemd service
# Usage: Called by Waybar `custom/vpn` on click
# Dependencies: systemctl, ip
# Behavior: Stops/starts your retry service

if ip a | grep -q "10\.6\.0\."; then
  # VPN active → stop service (disconnect)
  systemctl stop nordvpn-retry.service
  systemctl stop nordvpnd.service
else
  # VPN inactive → start service (connect)
  systemctl start nordvpn-retry.service
fi

