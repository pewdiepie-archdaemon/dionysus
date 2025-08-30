#!/bin/bash
# workspace-3.sh — highlight workspace 3 if active

active=$(hyprctl activeworkspace -j | jq '.id')

if [ "$active" -eq 3 ]; then
  echo "[<span foreground='#fab387'>●</span>]"
else
  echo "[В]"
fi

