# EWW System Widgets & HUD Configuration

<div align="center">

![EWW HUD Demo](../../assets/demo-eww.png)

**Advanced system monitoring with ASCII art aesthetics**

</div>

## Overview

This EWW (Elkowar's Wacky Widgets) configuration creates a comprehensive cyberpunk-inspired system HUD that displays real-time system information through ASCII art visualizations, sensor monitoring, and network statistics.

## Files Structure

```
eww/
├── eww.yuck                    # Widget definitions and layouts
├── eww.scss                    # Styling and themes
├── eww-state.yml              # State management configuration
├── scripts/                    # Data collection scripts
│   ├── ascii/                 # ASCII art generators
│   │   └── ascii_core_layout.sh
│   ├── audio/                 # Audio processing
│   │   ├── audio_cava_status.sh
│   │   └── audio_visualizer.py
│   ├── bar/                   # Progress bar rendering
│   │   └── bar_render.sh
│   ├── net/                   # Network monitoring
│   │   ├── net_download.sh
│   │   ├── net_download_bar.sh
│   │   ├── net_ping.sh
│   │   ├── net_ping_latency.sh
│   │   ├── net_upload.sh
│   │   ├── net_upload_bar.sh
│   │   ├── net_vpn.sh
│   │   └── net_vpn_bar.sh
│   └── sys/                   # System monitoring
│       ├── sys_cpu_voltage.sh
│       ├── sys_dc_voltage.sh
│       ├── sys_fan_bar.sh
│       ├── sys_fan_spin.sh
│       ├── sys_gpu_voltage.sh
│       └── sys_workspace.sh
└── windows/                   # Widget window definitions
    ├── ascii/                 # ASCII-based display widgets
    │   ├── audio_status.yuck
    │   └── visualizer_window.yuck
    ├── bar/                   # System monitoring bars
    │   └── cpu_ram_storage_bars.yuck
    ├── misc/                  # Miscellaneous widgets
    │   └── welcome_text.yuck
    ├── net/                   # Network status widgets
    │   ├── ascii_decor_frame.yuck
    │   ├── net_bars.yuck
    │   └── right_internet_text.yuck
    └── sys/                   # System information widgets
        ├── active_workspace.yuck
        ├── four_boxes.yuck
        ├── orange_workspace.yuck
        ├── power_cooling_header_text.yuck
        ├── power_mode_text.yuck
        ├── right_fan_data.yuck
        └── workspace_window_text.yuck
```

## Core Features

### 🎛️ System Monitoring
- **Real-time CPU, RAM, and storage** usage with visual bars
- **Temperature monitoring** from multiple sensors
- **Voltage readings** for CPU, GPU, and DC rails
- **Fan speed monitoring** with RPM display and visual indicators

### 🌐 Network Monitoring  
- **Bandwidth monitoring** with upload/download bars
- **Ping latency** testing with visual indicators
- **VPN status** detection and connection quality
- **Network interface** status and statistics

### 🎵 Audio Integration
- **Cava visualizer** integration with ASCII output
- **Audio device status** monitoring
- **Volume level** visualization
- **Real-time waveform** display

### 🖥️ Workspace Management
- **Active workspace** indication
- **Window count** per workspace
- **Workspace switching** visual feedback
- **Multi-monitor** support

## Widget Components

### System Information Widgets

**CPU, RAM & Storage Bars (`cpu_ram_storage_bars.yuck`)**
```yuck
(defwidget system-bars []
  (box :orientation "v" :space-evenly false
    (cpu-bar)
    (ram-bar) 
    (storage-bar)))
```

**Temperature & Power Monitoring (`four_boxes.yuck`)**
```yuck
(defwidget power-monitoring []
  (box :class "power-grid"
    (temp-box)
    (voltage-box)
    (fan-box)
    (power-box)))
```

### Network Widgets

**Bandwidth Monitoring (`net_bars.yuck`)**
```yuck
(defwidget network-stats []
  (box :orientation "v"
    (download-bar)
    (upload-bar)
    (ping-indicator)
    (vpn-status)))
```

**Connection Status (`right_internet_text.yuck`)**
```yuck
(defwidget connection-info []
  (box :class "net-info"
    (network-interface)
    (ip-address)
    (connection-quality)))
```

### Audio Visualization

**Cava Integration (`visualizer_window.yuck`)**
```yuck
(defwidget audio-visualizer []
  (box :class "visualizer"
    (label :text {cava-output}
           :class "ascii-bars")))
```

**Audio Status (`audio_status.yuck`)**
```yuck
(defwidget audio-controls []
  (box :orientation "h"
    (volume-slider)
    (audio-device-info)
    (mute-indicator)))
```

## Script Documentation

### System Monitoring Scripts

**CPU Voltage Monitoring (`sys_cpu_voltage.sh`)**
```bash
#!/bin/bash
# Monitor CPU voltage from sensors
sensors | grep -E "in[0-9]" | awk '{print $2}' | tr -d 'V+'
```

**Fan Speed Monitoring (`sys_fan_spin.sh`)**
```bash
#!/bin/bash
# Get fan RPM and create visual representation
fan_rpm=$(sensors | grep -i fan | awk '{print $2}')
echo "Fan: ${fan_rpm} RPM"
```

**GPU Voltage (`sys_gpu_voltage.sh`)**
```bash
#!/bin/bash
# NVIDIA GPU voltage monitoring
nvidia-smi --query-gpu=voltage.graphics --format=csv,noheader,nounits
```

### Network Monitoring Scripts

**Download Speed (`net_download.sh`)**
```bash
#!/bin/bash
# Monitor download bandwidth
interface="wlp4s0"
rx_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
# Calculate speed and format output
```

**VPN Status (`net_vpn.sh`)**
```bash
#!/bin/bash
# Check VPN connection status
if ip route | grep -q "10.6.0"; then
    echo "🔒 VPN Active"
else
    echo "🔓 No VPN"
fi
```

**Ping Latency (`net_ping_latency.sh`)**
```bash
#!/bin/bash
# Test network latency
ping -c 1 8.8.8.8 | grep -o 'time=[0-9.]*' | cut -d= -f2
```

### Audio Processing Scripts

**Audio Visualizer (`audio_visualizer.py`)**
```python
#!/usr/bin/env python3
import time
import subprocess

def process_cava_data():
    try:
        with open('/tmp/cava.raw', 'r') as f:
            data = f.read().strip()
            # Process and format ASCII bars
            return format_ascii_bars(data)
    except FileNotFoundError:
        return "No audio data"

def format_ascii_bars(raw_data):
    # Convert raw Cava output to styled ASCII
    bars = raw_data.split()
    formatted = ""
    for bar in bars:
        height = int(bar) if bar.isdigit() else 0
        formatted += "█" * (height // 10)
    return formatted

while True:
    output = process_cava_data()
    with open('/tmp/visualizer.txt', 'w') as f:
        f.write(output)
    time.sleep(0.1)
```

## Styling Configuration

### Theme Variables (`eww.scss`)
```scss
// Color palette
$bg-primary: #0a0a0f;
$fg-primary: #7dcfff;
$accent-green: #39ff14;
$accent-yellow: #ffff00;
$accent-pink: #ff1493;

// Widget styling
.system-bars {
  background: $bg-primary;
  border: 2px solid $accent-green;
  border-radius: 8px;
  padding: 10px;
}

.ascii-visualizer {
  font-family: "JetBrains Mono";
  font-size: 10px;
  color: $accent-green;
  background: transparent;
}

.network-stats {
  background: linear-gradient(45deg, $bg-primary, #1a1a2e);
  border: 1px solid $fg-primary;
}
```

### Responsive Design
```scss
// Adaptive sizing
@media (max-width: 1920px) {
  .system-widget {
    scale: 0.9;
  }
}

@media (max-width: 1366px) {
  .system-widget {
    scale: 0.8;
  }
}
```

## Installation & Setup

### Launch Full HUD
```bash
# Start all widgets
eww open-many active_workspace \
               ascii_decor_frame \
               audio_status \
               cpu_ram_storage_bars \
               four_boxes \
               net_bars \
               orange_workspace \
               power-cooling_header_text \
               power_mode_text \
               right_fan_data \
               right_internet_text \
               visualizer_window \
               welcome_text \
               workspace_window_text
```

### Auto-start with Hyprland
```bash
# Add to hyprland.conf
exec-once = ~/.config/eww/scripts/audio/audio_visualizer.py &
exec-once = cava -p ~/.config/cava/config &
exec-once = ~/.config/hypr/scripts/refresh-eww.sh &
```

### Systemd Service (Recommended)
```ini
# ~/.config/systemd/user/eww-hud.service
[Unit]
Description=EWW System HUD
After=hyprland.service

[Service]
Type=forking
ExecStart=/home/%i/.config/eww/scripts/start-hud.sh
Restart=on-failure

[Install]
WantedBy=default.target
```

## Dependencies

### Required Packages
```bash
# Core EWW
sudo pacman -S eww-wayland

# System monitoring
sudo pacman -S lm-sensors nvidia-utils

# Network tools  
sudo pacman -S curl iputils

# Audio processing
sudo pacman -S cava python

# Utilities
sudo pacman -S jq bc
```

### Sensor Setup
```bash
# Configure sensors
sudo sensors-detect

# Test sensor output
sensors
```

## Customization Guide

### Adding New Widgets

1. **Create widget definition** in appropriate `windows/` subdirectory
2. **Add data collection script** in `scripts/` subdirectory  
3. **Define styling** in `eww.scss`
4. **Register widget** in main `eww.yuck`

### Example: Custom CPU Temperature Widget
```yuck
(defwidget cpu-temp []
  (box :class "temp-widget"
    (label :text {cpu-temp-data}
           :class "temp-display")))

(deflisten cpu-temp-data :initial "0°C"
  "scripts/sys/cpu_temp.sh")
```

### Modifying Network Interface
```bash
# Update network scripts for your interface
sed -i 's/wlp4s0/your_interface/' scripts/net/*.sh
```

### Custom Color Schemes
```scss
// Modify theme variables in eww.scss
$accent-green: #00ff00;  // Change accent color
$bg-primary: #000000;    // Change background
```

## Troubleshooting

### Common Issues

**Widgets not displaying:**
```bash
# Check EWW daemon
eww ping

# Restart EWW
eww kill && eww daemon
```

**No sensor data:**
```bash
# Install and configure sensors
sudo pacman -S lm-sensors
sudo sensors-detect
```

**Network monitoring not working:**
```bash
# Check interface name
ip link show

# Update scripts with correct interface
```

**Audio visualizer not updating:**
```bash
# Check Cava output
cat /tmp/cava.raw

# Restart audio visualizer
pkill python3
~/.config/eww/scripts/audio/audio_visualizer.py &
```

### Performance Optimization

**Reduce update frequency:**
```bash
# Modify polling intervals in scripts
sleep 0.5  # Instead of sleep 0.1
```

**Selective widget loading:**
```bash
# Load only essential widgets
eww open cpu_ram_storage_bars
eww open net_bars
```

## Advanced Features

### Multi-Monitor Support
```yuck
(defwidget monitor-specific-hud []
  (box :class "hud-container"
       :space-evenly false
    (if {monitor == "DP-1"}
        (primary-monitor-widgets)
        (secondary-monitor-widgets))))
```

### Dynamic Widget Positioning
```scss
.widget-container {
  position: absolute;
  top: calc(var(--monitor-height) * 0.1);
  left: calc(var(--monitor-width) * 0.02);
}
```

### Integration with External APIs
```bash
#!/bin/bash
# Weather widget integration
curl -s "wttr.in/YourCity?format=3" | head -1
```

---

<div align="center">

![EWW Demo GIF](../../assets/demo-eww.gif)

**Part of the Dionysus desktop environment**

*Advanced system monitoring with cyberpunk aesthetics*

*"God speed if you try and get this running yourself" - Original Author*

</div>
