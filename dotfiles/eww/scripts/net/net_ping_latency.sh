#!/usr/bin/env bash
# Usage: ./net_ping_latency.sh <ms>

ms=$1
lines=5
max_ms=200    # adjust scale (200ms = 100%)

# Scale ping ms → percentage
percent=$(( ms * 100 / max_ms ))
if [ "$percent" -gt 100 ]; then percent=100; fi
if [ "$percent" -lt 0 ]; then percent=0; fi

# Calculate filled rows
filled=$(( (percent * lines + 99) / 100 ))
if (( ms > 0 && filled == 0 )); then
  filled=1
fi

for ((i=0; i<lines; i++)); do
  row=$((lines - i))
  if (( row <= filled )); then
    if (( row == filled )); then
      echo "╽"
    else
      echo "█"
    fi
  else
    echo "│"
  fi
done

