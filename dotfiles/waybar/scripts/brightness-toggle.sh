#!/usr/bin/env bash
# ── brightness-toggle.sh ─────────────────────────────
# Description: Cycle screen brightness between 30%, 60%, and 100%
# Usage: Waybar `custom/brightness` on-click
# Dependencies: brightnessctl
# ─────────────────────────────────────────────────────

current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current * 100 / max))

if [ "$percent" -lt 45 ]; then
  brightnessctl set 60%
elif [ "$percent" -lt 85 ]; then
  brightnessctl set 100%
else
  brightnessctl set 30%
fi

