#!/bin/bash
# ── mic.sh ─────────────────────────────────────────────────
# Description: Shows microphone mute/unmute status with icon
# Usage: Called by Waybar `custom/microphone` module every 1s
# Dependencies: pactl (PulseAudio / PipeWire)
# Output: Pango markup (colored icon in brackets)
# Example: <span foreground='#fab387'>[  ]</span>  (muted)
#          <span foreground='#56b6c2'>[  ]</span>  (active)

if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes'; then
  # Muted → mic-off icon
  echo "<span foreground='#fab387'>[  ]</span>"
else
  # Active → mic-on icon
  echo "<span foreground='#56b6c2'>[  ]</span>"
fi

