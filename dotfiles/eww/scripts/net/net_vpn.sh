#!/usr/bin/env bash
# net_vpn.sh — numeric for the bar
if ip a | grep -q "10\.6\.0\."; then
  echo 100
else
  echo 0
fi

