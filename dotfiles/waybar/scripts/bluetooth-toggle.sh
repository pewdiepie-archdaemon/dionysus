#!/usr/bin/env bash
# ── bluetooth-toggle.sh ──────────────────────────────────────────────────────
# Toggle Bluetooth on/off using rfkill.
# Usage: Waybar `bluetooth` module :on-click
# Output: (changes state only)
# ───────────────────────────────────────────────────────────────────────────── 

if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
    rfkill unblock bluetooth
else
    rfkill block bluetooth
fi

