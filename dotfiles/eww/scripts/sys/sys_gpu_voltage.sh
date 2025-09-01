#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  Reads NVIDIA GPU voltage using nvidia-smi and prints it in millivolts.
# ─────────────────────────────────────────────────────────────────────────────
sensors | awk '/vddgfx/ {print $2 " mV"}' || echo "N/A"

