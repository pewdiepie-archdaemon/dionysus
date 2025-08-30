#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
#  Toggles ASUS keyboard backlight "breathing" effect.
#  Bound to XF86Launch3 (F4) in Hyprland config.
#  Not the smoothest but it works lol.
# ─────────────────────────────────────────────────────────────────────────────

KEY_BRIGHTNESS_PATH="/sys/class/leds/asus::kbd_backlight/brightness"
MAX_BRIGHTNESS=$(cat /sys/class/leds/asus::kbd_backlight/max_brightness)

SLEEP_TIME=0.2  # Adjust speed for slower effect
MIN_BRIGHTNESS=1  # Prevents light from turning completely off
PID_FILE="/tmp/kbd-breathing.pid"

# If the script is already running, stop it
if [[ -f "$PID_FILE" ]]; then
    kill "$(cat $PID_FILE)"
    rm "$PID_FILE"
    echo 3 > $KEY_BRIGHTNESS_PATH  # Restore normal brightness
    exit 0
fi

# Store process ID
echo $$ > "$PID_FILE"

while true; do
    # Fade in
    for level in $(seq $MIN_BRIGHTNESS $MAX_BRIGHTNESS); do
        echo $level > $KEY_BRIGHTNESS_PATH
        sleep $SLEEP_TIME
    done

    # Fade out (but never go below MIN_BRIGHTNESS)
    for level in $(seq $MAX_BRIGHTNESS -1 $MIN_BRIGHTNESS); do
        echo $level > $KEY_BRIGHTNESS_PATH
        sleep $SLEEP_TIME
    done
done
