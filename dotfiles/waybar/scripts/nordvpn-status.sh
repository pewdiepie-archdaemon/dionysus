#!/bin/bash
# ── nordvpn-status.sh ──────────────────────────────────────
# Description: Checks if VPN interface is active via IP range
# Usage: Called by Waybar `custom/vpn` every 5s
# Dependencies: ip, curl (optional, for country lookup)
# Output: Pango markup → [УЗЕЛ]: Country or KAPUTT
# Example: <span foreground='#fab387'>[УЗЕЛ]: Japan</span>
#          <span foreground='#bf616a'>[НЕТ СВЯЗИ]</span>
# ───────────────────────────────────────────────────────────

#!/bin/bash

if sudo ipsec statusall 2>/dev/null | grep -q "ESTABLISHED"; then
  country=$(curl -s ifconfig.co/country 2>/dev/null)
  [[ -z "$country" ]] && country="НЕУСТАНОВЛЕНО"
  echo "<span foreground='#fab387'>[УЗЕЛ]: $country</span>"
else
  echo "<span foreground='#bf616a'>[НЕТ СВЯЗИ]/span>"
fi
