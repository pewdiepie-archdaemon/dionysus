#!/usr/bin/env bash
# takes 100 or 0 and renders a 5-line bar

percent=$1
lines=5

if [ "$percent" -eq 100 ]; then
  for ((i=0; i<lines; i++)); do
    echo "█"
  done
else
  for ((i=0; i<lines; i++)); do
    echo "│"
  done
fi

