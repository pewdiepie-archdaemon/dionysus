#!/usr/bin/env bash
# net_ping.sh — measure ping to 1.1.1.1, output ms (integer)

ping -c 1 -w 2 1.1.1.1 2>/dev/null \
  | grep 'time=' \
  | awk -F'time=' '{print int($2)}' \
  || echo 0

