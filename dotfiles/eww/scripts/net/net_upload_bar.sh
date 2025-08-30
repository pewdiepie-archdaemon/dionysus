#!/usr/bin/env bash
# Usage: ./upload_bar.sh <percentage>

percent=$1
lines=5

# Cap 0–100
if [ "$percent" -gt 100 ]; then percent=100; fi
if [ "$percent" -lt 0 ]; then percent=0; fi

# Scale percentage into rows (round up)
filled=$(( (percent * lines + 99) / 100 ))

# Always show at least one block if >0
if (( percent > 0 && filled == 0 )); then
  filled=1
fi

# Draw from top to bottom
for ((i=0; i<lines; i++)); do
  row=$((lines - i))  # count from top
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

