#!/bin/bash
# ── nordvpn-status.sh ──────────────────────────────────────
# Description: Checks if VPN interface is active via IP range
# Usage: Called by Waybar `custom/vpn` every 5s
# Dependencies: ip, curl (optional, for country lookup)
# Output: Pango markup → [ФАНТОМ]: Country or KAPUTT
# Example: <span foreground='#fab387'>[ФАНТОМ]: Japan</span>
#          <span foreground='#bf616a'>[ФАНТОМ]: KAPUTT</span>

if ip a | grep -q "10\.6\.0\."; then
  # VPN is active → try to resolve country
  country=$(curl -s ifconfig.co/country 2>/dev/null)
  [[ -z "$country" ]] && country="UNKNOWN"
  echo "<span foreground='#fab387'>[ФАНТОМ]: $country</span>"
else
  # VPN inactive
  echo "<span foreground='#bf616a'>[ФАНТОМ]: KAPUTT</span>"
fi

