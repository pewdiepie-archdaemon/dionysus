#!/bin/bash

# Prevent multiple daemons
if ! pgrep -x eww > /dev/null; then
    echo "[eww-autostart] Starting Eww daemon..."
    eww daemon &
    sleep 1.5
else
    echo "[eww-autostart] Eww daemon already running."
fi

# Define all your windows
eww_windows=(active_workspace
             ascii_decor_frame
             audio_status
             cpu_ram_storage_bars
             four_boxes
             net_bars
             orange_workspace 
             power-cooling_header_text
             power_mode_text 
             right_fan_data
             right_internet_text
             visualizer_window
             welcome_text
             workspace_window_text
             )

# Open them all (even if already open — no problem)
for win in "${eww_windows[@]}"; do
  eww open "$win"
done

echo "[eww-autostart] All Eww windows launched."

