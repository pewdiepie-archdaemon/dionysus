#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
#  Hyprland autostart script.
#  Runs at Hyprland startup via `exec-once` in hyprland.conf.
#  - Starts Alacritty if not already running
#  - Restarts swww-daemon (wallpaper service) with a clean cache
#  - (Optional) Launch Waybar / Hyprpaper if enabled
# ─────────────────────────────────────────────────────────────────────────────

#pgrep -x waybar > /dev/null || waybar &
pgrep -x alacritty > /dev/null || alacritty &
#pgrep -x hyprpaper > /dev/null || hyprpaper &

pkill -x swww-daemon
rm -rf ~/.cache/swww
swww-daemon &
sleep 0.5
