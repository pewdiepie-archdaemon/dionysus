#!/bin/bash

logfile="/tmp/waybar_watcher_loop_final.log"

# Start hyprpaper if needed
if ! pgrep -x hyprpaper > /dev/null; then
    echo "Starting hyprpaper..." >> "$logfile"
    hyprpaper &
    sleep 1
fi

# Wallpapers
wallpaper_with_window="/home/pewds/.config/hypr/wallpapers/black.png"
wallpaper_without_window="/home/pewds/.config/hypr/wallpapers/bg_wallpaper.png"
hyprctl hyprpaper preload "$wallpaper_with_window"
hyprctl hyprpaper preload "$wallpaper_without_window"

current_wallpaper=""
eww_visible=$([ "$(eww active-windows)" ] && echo true || echo false)
waybar_visible=$(pgrep -x waybar >/dev/null 2>&1 && echo true || echo false)

monitor=$(hyprctl monitors -j | jq -r '.[0].name')

# Eww widgets
eww_windows="active_workspace \
             ascii_decor_frame \
             audio_status \
             cpu_ram_storage_bars \
             four_boxes \
             net_bars \
             orange_workspace \
             power-cooling_header_text \
             power_mode_text \
             right_fan_data \
             right_internet_text \
             visualizer_window \
             welcome_text \
             workspace_window_text"

while true; do
    echo "--- $(date) ---" >> "$logfile"

    active_workspace=$(hyprctl activeworkspace -j | jq -r '.id')
    window_count=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $active_workspace and .mapped == true)] | length")

    echo "Window count: $window_count" >> "$logfile"

    if [ "$window_count" -eq 0 ]; then
        # No windows → Eww on, Waybar off
        if [ "$current_wallpaper" != "$wallpaper_without_window" ]; then
            echo "Switching to wallpaper WITHOUT window" >> "$logfile"
            hyprctl hyprpaper wallpaper "$monitor,$wallpaper_without_window"
            current_wallpaper="$wallpaper_without_window"
        fi

        if ! $eww_visible; then
            echo "Launching Eww widgets..." >> "$logfile"
            pgrep -x eww || eww daemon &&
            eww open-many $eww_windows
            eww_visible=true
        fi

        if $waybar_visible; then
            echo "Stopping Waybar..." >> "$logfile"
            pkill -x waybar
            waybar_visible=false
        fi

    else
        # Windows → Waybar on, Eww off
        if [ "$current_wallpaper" != "$wallpaper_with_window" ]; then
            echo "Switching to wallpaper WITH window" >> "$logfile"
            hyprctl hyprpaper wallpaper "$monitor,$wallpaper_with_window"
            current_wallpaper="$wallpaper_with_window"
        fi

        if $eww_visible; then
            echo "Hiding Eww widgets..." >> "$logfile"
            eww close-all
            eww_visible=false
        fi

        if ! $waybar_visible; then
            echo "Starting Waybar..." >> "$logfile"
            nohup waybar >/dev/null 2>&1 &
            waybar_visible=true
        fi
    fi

    sleep 0.5
done

