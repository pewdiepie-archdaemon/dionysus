#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  °˖* ૮(  • ᴗ ｡)っ🍸  pewdiepie/archdaemon/dionysh
#  shhheersh
#  vers. 1.0
# ─────────────────────────────────────────────────────────────────────────────
#  Prints the status of workspaces 1–4 in Hyprland, marking the active one.
#  Output format: "wsN= [ ACTIVE ]" or "wsN= [INACTIVE]"
# ─────────────────────────────────────────────────────────────────────────────

# Get active workspace ID (requires jq + hyprctl)
CURRENT=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id')

# Fallback if query fails
if [[ -z "$CURRENT" || "$CURRENT" == "null" ]]; then
  echo "[!] Could not determine active workspace."
  exit 1
fi

for i in {1..4}; do
  if [[ "$i" -eq "$CURRENT" ]]; then
    echo "ws${i}= [ ACTIVE ]"
  else
    echo "ws${i}= [INACTIVE]"
  fi
done

