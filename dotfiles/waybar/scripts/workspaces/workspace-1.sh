#!/bin/bash
# workspace-1.sh — highlight workspace 1 if active

active=$(hyprctl activeworkspace -j | jq '.id')

if [ "$active" -eq 1 ]; then
  echo "[<span foreground='#fab387'>●</span>]"
else
  echo "[А]"
fi

