#!/bin/bash
sensors | awk '/vddgfx/ {print $2 " mV"}' || echo "N/A"

