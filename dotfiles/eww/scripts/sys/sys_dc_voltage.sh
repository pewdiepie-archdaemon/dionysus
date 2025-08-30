#!/bin/bash
sensors | awk '/in0:/ {print $2 " V"}' || echo "N/A"

