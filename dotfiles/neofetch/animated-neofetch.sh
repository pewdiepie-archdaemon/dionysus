#!/bin/bash
# ── animated-neofetch.sh ────────────────────────────────
# Description: Animated ASCII frames + cached neofetch/fastfetch system info
# Usage: ./animated-neofetch.sh [delay]

delay=${1:-0.1}
ascii_row=1
ascii_col=1
text_col=60

cache_file="$HOME/.cache/neofetch.txt"
mkdir -p ~/.cache

if [[ ! -f "$cache_file" || $(find "$cache_file" -mmin +60 2>/dev/null) ]]; then
  if command -v fastfetch >/dev/null 2>&1; then
    fastfetch --logo none > "$cache_file"
  else
    neofetch --disable ascii > "$cache_file"
  fi
fi

clear
tput cup $ascii_row $text_col
cat "$cache_file"

tput civis
trap 'tput cnorm; exit' INT TERM

while true; do
  for frame in ~/.config/neofetch/frames_colour/*.txt; do
    tput cup $ascii_row $ascii_col
    cat "$frame"

    # Wait a little, but also check if user pressed a key
    read -t $delay -n 1 key && { tput cnorm; exit; }
  done
done

