#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  net_download.sh
#  Samples network traffic on a given interface and reports download usage
#  as a percentage (0–100) of a configured max speed.
#  
#  Usage: ./net_download.sh
#  Example: output "42" → meaning 42% of max throughput.
#
# ─────────────────────────────────────────────────────────────────────────────

# Configuration
max_speed=12500000   # adjust: this is 100 Mbps (100*1e6 / 8)

# Dynamically detect active network interface
get_active_interface() {
    # Try to get the interface used for the default route (Linux)
    if command -v ip >/dev/null 2>&1; then
        local iface=$(ip route get 1.1.1.1 2>/dev/null | grep -o 'dev [^[:space:]]*' | head -1 | cut -d' ' -f2)
        
        # Fallback: get first active non-loopback interface
        if [ -z "$iface" ]; then
            iface=$(ip -br link show 2>/dev/null | awk '$2=="UP" && $1!="lo" {print $1; exit}')
        fi
    else
        # macOS fallback using route and netstat
        local iface=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
        
        # Alternative fallback for macOS
        if [ -z "$iface" ]; then
            iface=$(netstat -rn | grep '^default' | head -1 | awk '{print $6}')
        fi
    fi
    
    echo "$iface"
}

iface=$(get_active_interface)

# Validate interface
if [ -z "$iface" ]; then
    echo "0"  # No active interface found
    exit 1
fi

# Get network statistics (cross-platform)
get_rx_bytes() {
    local iface="$1"
    
    if [ -f "/proc/net/dev" ]; then
        # Linux - use /proc/net/dev
        awk -v iface="$iface" '$1 ~ "^" iface ":" {gsub(":", "", $1); print $2}' /proc/net/dev 2>/dev/null
    elif command -v netstat >/dev/null 2>&1; then
        # macOS/BSD - use netstat (bytes received)
        netstat -ibn | grep "^$iface " | head -1 | awk '{print $7}' 2>/dev/null
    else
        echo ""
    fi
}

# First sample
rx1=$(get_rx_bytes "$iface")
if [ -z "$rx1" ] || ! [[ "$rx1" =~ ^[0-9]+$ ]]; then
    echo "0"  # Invalid or missing data
    exit 1
fi

sleep 1

# Second sample
rx2=$(get_rx_bytes "$iface")
if [ -z "$rx2" ] || ! [[ "$rx2" =~ ^[0-9]+$ ]]; then
    echo "0"  # Invalid or missing data
    exit 1
fi

# Calculate bytes per second
bps=$((rx2 - rx1))

# Handle negative values (counter reset)
if [ "$bps" -lt 0 ]; then
    bps=0
fi

# Calculate percentage
percent=$((bps * 100 / max_speed))

# Clamp between 0–100
if [ "$percent" -gt 100 ]; then percent=100; fi
if [ "$percent" -lt 0 ]; then percent=0; fi

echo $percent

