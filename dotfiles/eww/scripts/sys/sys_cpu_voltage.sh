#!/bin/bash
sensors | awk '/vddnb:/ {printf "%s mV\n", $2}' || echo "N/A"

