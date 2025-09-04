#!/bin/bash
# ── volume.sh ─────────────────────────────────────────────
# Description: Shows current audio volume with ASCII bar + tooltip
# Usage: Waybar `custom/volume` every 1s
# Dependencies: wpctl, awk, bc, seq, printf
# ───────────────────────────────────────────────────────────

# Get raw volume and convert to int
vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $2 }')
vol_int=$(echo "$vol_raw * 100" | bc | awk '{ print int($1) }')

# Check mute status
is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo true || echo false)

# Get default sink description (human-readable)
sink=$(wpctl status | awk '/Sinks:/,/Sources:/' | grep '\*' | cut -d'.' -f2- | sed 's/^\s*//; s/\[.*//')

# Icon logic
if [ "$is_muted" = true ]; then
  icon=""
  vol_int=0
elif [ "$vol_int" -lt 50 ]; then
  icon=""
else
  icon=""
fi

# ASCII bar
filled=$((vol_int / 10))
empty=$((10 - filled))

bar=""
pad=""
((filled > 0)) && bar=$(printf '█%.0s' $(seq 1 $filled))
((empty > 0)) && pad=$(printf '░%.0s' $(seq 1 $empty))

ascii_bar="[$bar$pad]"

# Color logic
if [ "$is_muted" = true ] || [ "$vol_int" -lt 10 ]; then
  fg="#bf616a" # red
elif [ "$vol_int" -lt 50 ]; then
  fg="#fab387" # orange
else
  fg="#56b6c2" # cyan
fi

# Tooltip text
if [ "$is_muted" = true ]; then
  tooltip="Audio: Muted\nOutput: $sink"
else
  tooltip="Audio: $vol_int%\nOutput: $sink"
fi

vol_formatted=$(printf "%3d" "$vol_int")
# Final JSON output
echo "{\"text\":\"<span foreground='$fg'>$icon $ascii_bar $vol_formatted%</span>\",\"tooltip\":\"$tooltip\"}"

