# Cava Audio Visualizer Configuration

<div align="center">

![Cava Demo](../../assets/demo-cava.gif)

**ASCII audio visualization with cyberpunk aesthetics**

</div>

## Overview

This Cava configuration creates stunning ASCII-based audio visualizations that integrate seamlessly with the Dionysus desktop environment. The visualizer outputs raw data that can be consumed by EWW widgets and other system components.

## Files Structure

```
cava/
├── config                      # Main Cava configuration
├── shaders/                    # Custom visualization shaders
│   ├── bar_spectrum.frag      # Classic bar spectrum
│   ├── northern_lights.frag   # Aurora-inspired effect
│   ├── pass_through.vert      # Vertex shader base
│   ├── spectrogram.frag       # Frequency analysis
│   └── winamp_line_style_spectrum.frag  # Retro line visualization
└── README.md                   # This documentation
```

## Core Features

### ASCII Output Integration
- **Raw ASCII data** written to `/tmp/cava.raw`
- **Real-time processing** for smooth animations
- **EWW widget integration** for desktop display
- **Terminal visualization** capability

### Visual Styles
- **Multiple shader options** for different aesthetic preferences
- **Customizable bar styles** (solid, outline, gradient)
- **Color-coded frequency** response
- **Smooth interpolation** between frames

### Performance Optimization
- **Low CPU usage** through efficient processing
- **Configurable frame rates** for different hardware
- **Memory-efficient** buffering
- **Real-time audio capture** without lag

## Configuration Highlights

### Audio Input
```ini
[input]
method = pipewire              # Use PipeWire for audio capture
source = auto                  # Automatic source detection
```

### Visualization Settings
```ini
[output]
method = raw                   # Output raw ASCII data
data_format = ascii           # ASCII character output
ascii_max_range = 1000        # Maximum bar height
bar_width = 2                 # Character width per bar
bar_spacing = 1               # Space between bars
```

### Color Configuration
```ini
[color]
gradient = 1                  # Enable color gradients
gradient_color_1 = '#39ff14'  # Neon green (low frequencies)
gradient_color_2 = '#7dcfff'  # Electric blue (mid frequencies)  
gradient_color_3 = '#ff1493'  # Cyber pink (high frequencies)
gradient_color_4 = '#ffff00'  # Radioactive yellow (peak)
```

### Smoothing and Responsiveness
```ini
[smoothing]
monstercat = 1                # Enable smoothing algorithm
waves = 0                     # Disable wave effects
noise_reduction = 0.77        # Reduce background noise
```

## Custom Shaders

### Bar Spectrum (`bar_spectrum.frag`)
Classic vertical bar visualization with customizable colors and spacing.

```glsl
// Frequency-based color mapping
vec3 getColor(float frequency, float amplitude) {
    if (frequency < 0.3) return neonGreen * amplitude;
    else if (frequency < 0.6) return electricBlue * amplitude;
    else return cyberPink * amplitude;
}
```

### Northern Lights (`northern_lights.frag`)
Aurora-inspired flowing visualization with dynamic color shifts.

```glsl
// Flowing aurora effect
vec3 aurora = mix(baseColor, accentColor, 
                  sin(time + frequency * 10.0) * 0.5 + 0.5);
```

### Spectrogram (`spectrogram.frag`)
Frequency analysis display showing spectral content over time.

```glsl
// Time-based frequency display
float intensity = getFrequencyAtTime(frequency, time);
vec3 color = heatmapColor(intensity);
```

## Integration with EWW

### Audio Visualizer Script
The configuration works with the custom Python script for EWW integration:

```python
# /tmp/audio_visualizer.py
import subprocess
import time

def process_cava_output():
    with open('/tmp/cava.raw', 'r') as f:
        data = f.read().strip()
        # Process and format for EWW display
        return format_for_eww(data)
```

### EWW Widget Integration
```yuck
(defwidget audio-visualizer []
  (box :class "visualizer-container"
       :orientation "v"
    (label :text {audio-viz-data}
           :class "ascii-visualizer")))
```

## Usage Examples

### Basic Terminal Visualization
```bash
# Start Cava with custom config
cava -p ~/.config/cava/config

# Monitor raw output
watch -n 0.1 cat /tmp/cava.raw
```

### Integration with System
```bash
# Auto-start with Hyprland
exec-once = cava -p ~/.config/cava/config &

# EWW visualizer
exec-once = ~/.config/eww/scripts/audio/audio_visualizer.py &
```

### Custom Shader Testing
```bash
# Test specific shader
cava -p ~/.config/cava/config -f shader=northern_lights

# Compare different effects
cava -p ~/.config/cava/config -f shader=bar_spectrum
```

## Advanced Configuration

### Audio Source Selection
```ini
[input]
method = pipewire
source = alsa_output.pci-0000_00_1f.3.analog-stereo.monitor
```

### Performance Tuning
```ini
[general]
framerate = 60               # Smooth animation
bars = 32                    # Optimal bar count
bar_width = 2               # Balance detail/performance
```

### Custom Frequency Ranges
```ini
[eq]
1 = 2    # Bass boost
2 = 2    # Low-mid boost  
3 = 1    # Mid neutral
4 = 1    # High-mid neutral
5 = 3    # Treble boost
```

## Troubleshooting

### Common Issues

**No audio input detected:**
```bash
# Check PipeWire status
systemctl --user status pipewire

# List available sources
pactl list sources short
```

**Visualization not updating:**
```bash
# Check raw output file
ls -la /tmp/cava.raw

# Verify file permissions
chmod 644 /tmp/cava.raw
```

**Performance issues:**
```bash
# Reduce frame rate
sed -i 's/framerate = 60/framerate = 30/' ~/.config/cava/config

# Decrease bar count
sed -i 's/bars = 32/bars = 16/' ~/.config/cava/config
```

### Audio System Configuration

**PipeWire setup:**
```bash
# Install PipeWire
sudo pacman -S pipewire pipewire-pulse pipewire-alsa

# Enable services
systemctl --user enable pipewire pipewire-pulse
```

**Alternative audio systems:**
```ini
# For ALSA
[input]
method = alsa
source = hw:0,0

# For PulseAudio  
[input]
method = pulse
source = auto
```

## Customization Guide

### Creating Custom Themes

1. **Modify color gradients** in the config file
2. **Adjust bar styling** for different aesthetics
3. **Create custom shaders** for unique effects
4. **Fine-tune responsiveness** for your audio setup

### Color Schemes

**Cyberpunk Theme:**
```ini
gradient_color_1 = '#39ff14'  # Matrix green
gradient_color_2 = '#00ffff'  # Cyan
gradient_color_3 = '#ff1493'  # Hot pink
gradient_color_4 = '#ffff00'  # Electric yellow
```

**Ocean Theme:**
```ini
gradient_color_1 = '#0077be'  # Deep blue
gradient_color_2 = '#00a8cc'  # Cyan blue
gradient_color_3 = '#7dcfff'  # Light blue
gradient_color_4 = '#ffffff'  # White foam
```

## Dependencies

### Required Packages
```bash
sudo pacman -S cava           # Core visualizer
sudo pacman -S pipewire       # Audio system
```

### Optional Enhancements
```bash
sudo pacman -S python         # For processing scripts
sudo pacman -S fftw           # Enhanced FFT processing
```

## Advanced Features

### Multi-Monitor Setup
Configure different visualizations for multiple displays:

```bash
# Primary display
cava -p ~/.config/cava/config &

# Secondary display  
cava -p ~/.config/cava/config_secondary &
```

### Integration Scripts
Custom scripts for enhanced functionality:

```bash
#!/bin/bash
# Toggle visualizer on/off
if pgrep -x "cava" > /dev/null; then
    pkill cava
    echo "Visualizer stopped"
else
    cava -p ~/.config/cava/config &
    echo "Visualizer started"
fi
```

---

<div align="center">

![Cava Demo 2](../../assets/demo-cava-2.gif)

**Part of the Dionysus desktop environment**

*Real-time audio visualization with cyberpunk aesthetics*

</div>
