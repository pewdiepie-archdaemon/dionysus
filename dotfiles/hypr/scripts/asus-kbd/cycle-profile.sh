#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
#  Cycles ASUS performance profiles (Performance → Balanced → Silent).
#  Uses `asusctl profile` for switching.
#  Bound to XF86Launch4 (F5) in Hyprland config.
# ─────────────────────────────────────────────────────────────────────────────

# Define available profiles
PROFILES=("Quiet" "Balanced" "Performance")

# Get the current profile
CURRENT_PROFILE=$(asusctl profile -p | grep "Active profile" | awk -F' ' '{print $NF}')


# Debugging output
echo "Detected current profile: '$CURRENT_PROFILE'"

# Find the next profile in the list
NEXT_PROFILE=""
for ((i = 0; i < ${#PROFILES[@]}; i++)); do
    if [[ "${PROFILES[$i]}" == "$CURRENT_PROFILE" ]]; then
        NEXT_INDEX=$(( (i + 1) % ${#PROFILES[@]} ))
        NEXT_PROFILE="${PROFILES[$NEXT_INDEX]}"
        break
    fi
done

# Debugging output
echo "Switching to profile: '$NEXT_PROFILE'"

# Attempt to switch profiles
if [[ -n "$NEXT_PROFILE" ]]; then
    asusctl profile -P "$NEXT_PROFILE"
    echo "Profile switched successfully."
else
    echo "Error: Could not determine next profile."
fi
