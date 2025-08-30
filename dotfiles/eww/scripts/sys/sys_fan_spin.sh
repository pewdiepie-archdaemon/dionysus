#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  °˖* ૮(  • ᴗ ｡)っ🍸  pewdiepie/archdaemon/dionysh
#  shhheersh
#  vers. 1.1
# ─────────────────────────────────────────────────────────────────────────────
#  Script: sys_fan_spin.sh
#  Purpose: Displays fan spinner animation (CPU/GPU) based on RPM
#  Example:
#      ./sys_fan_spin.sh cpu
# ─────────────────────────────────────────────────────────────────────────────


SPIN=('|' '/' '-' '\\')
fan="$1"

# Simple cache file to track frame index across calls
cache="/tmp/${fan}_fan_frame"

if [ -f "$cache" ]; then
  index=$(<"$cache")
else
  index=0
fi

# Advance frame
index=$(( (index + 1) % ${#SPIN[@]} ))
echo "$index" > "$cache"

# Get RPM
if [ "$fan" = "cpu" ]; then
  rpm=$(sensors | grep -i 'cpu_fan' | awk '{print $2}')
elif [ "$fan" = "gpu" ]; then
  rpm=$(sensors | grep -i 'gpu_fan' | awk '{print $2}')
else
  rpm=0
fi
[ -z "$rpm" ] && rpm=0

if [ "$rpm" -eq 0 ]; then
  echo "|"
else
  echo "${SPIN[$index]}"
fi

