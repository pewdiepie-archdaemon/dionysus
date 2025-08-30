#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  °˖* ૮(  • ᴗ ｡)っ🍸  pewdiepie/archdaemon/dionysh
#  shhheersh
#  vers. 1.1
# ─────────────────────────────────────────────────────────────────────────────
#  Converts a numeric percentage (0–100) into an ASCII block bar.
#  Example:
#      ./usage_render_bar.sh 73
#      ███████▓░░
# ─────────────────────────────────────────────────────────────────────────────

usage=$1  # pass percentage as the first argument
full="█"
half="▓"
empty="░"

blocks=10
filled=$(( usage * blocks / 100 ))
bar=""

for ((i=0; i<blocks; i++)); do
  if [ $i -lt $filled ]; then
    bar+="$full"
  else
    bar+="$empty"
  fi
done

echo "$bar"
