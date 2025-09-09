#!/usr/bin/env bash
# ~/.config/eww/scripts/net/net_vpn_status.sh
# Show VPN status + country (for Eww)

if sudo /usr/bin/ipsec statusall 2>/dev/null | grep -q "ESTABLISHED"; then
  country=$(curl -s ifconfig.co/country 2>/dev/null)
  [[ -z "$country" ]] && country="НЕУСТАНОВЛЕНО"
  echo "[УЗЕЛ] $country"
else
  echo "[НЕТ СВЯЗИ]"
fi
