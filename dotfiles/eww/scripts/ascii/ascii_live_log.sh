#!/bin/bash
grep 'installed' /var/log/pacman.log | tail -n 10 | sed -E 's/^.*installed //' | cut -d' ' -f1 | jq -R -s -c 'split("\n")[:-1]'

