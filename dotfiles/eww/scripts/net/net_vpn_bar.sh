#!/usr/bin/env bash
# ~/.config/eww/scripts/net/net_vpn_bar.sh
# Render a 5-line bar directly based on VPN local detection (no external calls).

lines=5
VPN_NETS_REGEX="${VPN_NETS_REGEX:-^10\\.6\\.}"
if ip -4 -o addr show 2>/dev/null | awk -v re="$VPN_NETS_REGEX" '$3=="inet" && $4 ~ re {found=1} END{exit !found}' \
   || (command -v ipsec >/dev/null 2>&1 && ipsec statusall 2>/dev/null | grep -q "ESTABLISHED"); then
  # VPN is up → full block bar
  for ((i=0; i<lines; i++)); do
    echo "█"
  done
else
  # VPN is down → thin bar
  for ((i=0; i<lines; i++)); do
    echo "│"
  done
fi

