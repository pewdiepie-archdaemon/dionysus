#!/usr/bin/env bash
# ~/.config/eww/scripts/net/net_vpn_status.sh
# Show VPN status (local check, no external calls)

VPN_NETS_REGEX="${VPN_NETS_REGEX:-^10\\.6\\.}"
if ip -4 -o addr show 2>/dev/null | awk -v re="$VPN_NETS_REGEX" '$3=="inet" && $4 ~ re {found=1} END{exit !found}' \
   || (command -v ipsec >/dev/null 2>&1 && ipsec statusall 2>/dev/null | grep -q "ESTABLISHED"); then
  echo "[VPN]"
else
  echo ""
fi

