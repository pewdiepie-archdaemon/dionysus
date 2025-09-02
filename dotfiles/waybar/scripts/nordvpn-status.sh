#!/usr/bin/env bash
# ── nordvpn-status.sh ──────────────────────────────────────
# Description: Checks if VPN interface is active via IP range
# Usage: Called by Waybar `custom/vpn` every 5s
# Dependencies: ip (no external calls in steady state)
# Output: Pango markup → [VPN] or empty
# Example: <span foreground='#fab387'>[ФАНТОМ]: Japan</span>
#          <span foreground='#bf616a'>[ФАНТОМ]: KAPUTT</span>
# ───────────────────────────────────────────────────────────

VPN_NETS_REGEX="${VPN_NETS_REGEX:-^10\\.6\\.}"
if ip -4 -o addr show 2>/dev/null | awk -v re="$VPN_NETS_REGEX" '$3=="inet" && $4 ~ re {found=1} END{exit !found}' \
   || (command -v ipsec >/dev/null 2>&1 && ipsec statusall 2>/dev/null | grep -q "ESTABLISHED"); then
  echo "<span foreground='#fab387'>[VPN]</span>"
else
  echo ""
fi

