#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  sys_cpu_voltage.sh
#  Reads CPU voltage (in0) from lm-sensors and prints it in volts.
#  Requires: lm-sensors (and sensors-detect configured)
# ─────────────────────────────────────────────────────────────────────────────

sensors | awk '/in0:/ {print $2 " V"}' || echo "N/A"


