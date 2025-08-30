#!/bin/bash

ws=$(hyprctl activeworkspace -j | jq -r '.id')

cat <<EOF > /tmp/core_layout.txt
                 ─┐     ┌─
                  [  $ws  ]
                 ─┘     └─
EOF
