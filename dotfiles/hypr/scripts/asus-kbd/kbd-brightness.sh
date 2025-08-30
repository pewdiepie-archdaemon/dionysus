#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
#  Adjusts ASUS keyboard backlight brightness (up/down).
#  Reads max brightness from sysfs.
#  Bound to XF86KbdBrightnessUp (F3) / XF86KbdBrightnessDown (Fn2).
# ─────────────────────────────────────────────────────────────────────────────

KEY_BRIGHTNESS_PATH="/sys/class/leds/asus::kbd_backlight/brightness"
MAX_BRIGHTNESS=$(cat /sys/class/leds/asus::kbd_backlight/max_brightness)

case "$1" in
    up)
        BRIGHTNESS=$(cat $KEY_BRIGHTNESS_PATH)
        if [ "$BRIGHTNESS" -lt "$MAX_BRIGHTNESS" ]; then
            echo $((BRIGHTNESS + 1)) | sudo tee $KEY_BRIGHTNESS_PATH
        fi
        ;;
    down)
        BRIGHTNESS=$(cat $KEY_BRIGHTNESS_PATH)
        if [ "$BRIGHTNESS" -gt 0 ]; then
            echo $((BRIGHTNESS - 1)) | sudo tee $KEY_BRIGHTNESS_PATH
        fi
        ;;
esac

