# Neofetch Animated System Information

<div align="center">

![Neofetch Demo](../../assets/demo-neofetch.gif)

**Cyberpunk-inspired animated system information display**

</div>

## Overview

This Neofetch configuration provides an animated ASCII art system information display that perfectly embodies the Dionysus cyberpunk aesthetic. The setup features smooth frame transitions and optimized performance for daily use.

## Files Structure

```
neofetch/
├── config.conf               # Main Neofetch configuration
├── myascii.txt               # Static ASCII art (fallback)
├── animated-neofetch.sh      # Animation control script
├── frames_colour/            # Animation frame sequences (47 frames)
│   ├── frame0001.txt         # Individual animation frames
│   ├── frame0002.txt         # with colored ASCII art
│   ├── frame0003.txt         # ...continuing through
│   ├── ...                   # ...all 47 frames for
│   ├── frame0046.txt         # ...smooth animation
│   └── frame0047.txt         # loops
└── README.md                 # This documentation
```

## Core Features

### 🎭 Animated ASCII Art
- **47 frame sequence** for smooth animation loops
- **Color-coded frames** with cyberpunk color palette
- **Optimized timing** for natural motion flow
- **Fallback static art** for compatibility

### ⚡ Performance Optimization  
- **Cached output** for instant display on subsequent runs
- **Minimal system impact** through efficient scripting
- **Fast loading** with pre-computed animations
- **Memory efficient** frame management

### 🎨 Visual Design
- **Neon-radioactive colors** matching desktop theme
- **Minimal information layout** focused on essential stats
- **Clean typography** with optimal readability
- **Consistent styling** with other Dionysus components

## Configuration Highlights

### System Information Display
```bash
# Essential information only
print_info() {
    info title
    info underline
    
    info "OS" distro
    info "Host" model
    info "Kernel" kernel
    info "Uptime" uptime
    info "Packages" packages
    info "Shell" shell
    info "Resolution" resolution
    info "DE" de
    info "WM" wm
    info "Theme" theme
    info "Icons" icons
    info "Terminal" term
    info "CPU" cpu
    info "GPU" gpu
    info "Memory" memory
    
    # Hide unnecessary info
    # info "GPU Driver" gpu_driver
    # info "Disk" disk
    # info "Battery" battery
    # info "Song" song
}
```

### ASCII Art Configuration
```bash
# ASCII art settings
ascii_distro="auto"
ascii_colors=(distro)
ascii_bold="on"

# Color palette (cyberpunk theme)
colors=(4 6 1 8 8 6)  # Blue, cyan, red, dark gray, dark gray, cyan
```

### Display Options
```bash
# Clean minimal output
crop_mode="normal"
crop_offset="center"

# Remove unwanted elements
show_icons="off"
separator=" →"

# Optimize for terminal display
stdout="off"
image_backend="ascii"
image_source="auto"
```

## Animation System

### Animation Script (`animated-neofetch.sh`)
```bash
#!/bin/bash
# Animated Neofetch with frame cycling

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMES_DIR="$SCRIPT_DIR/frames_colour"
CACHE_FILE="$HOME/.cache/neofetch.txt"
FRAME_DELAY=${1:-0.05}  # Default 50ms between frames

# Cache neofetch output for performance
cache_neofetch() {
    if [[ ! -f "$CACHE_FILE" || $(find "$SCRIPT_DIR/config.conf" -newer "$CACHE_FILE" 2>/dev/null) ]]; then
        neofetch --config "$SCRIPT_DIR/config.conf" --ascii "$SCRIPT_DIR/myascii.txt" > "$CACHE_FILE"
    fi
}

# Display animated frames
animate_frames() {
    local frame_count=$(ls "$FRAMES_DIR"/frame*.txt 2>/dev/null | wc -l)
    
    if [[ $frame_count -eq 0 ]]; then
        echo "No animation frames found in $FRAMES_DIR"
        return 1
    fi
    
    for frame in "$FRAMES_DIR"/frame*.txt; do
        clear
        cat "$frame"
        sleep "$FRAME_DELAY"
    done
}

# Main execution
main() {
    cache_neofetch
    
    # Show animation if frames exist
    if [[ -d "$FRAMES_DIR" && $(ls "$FRAMES_DIR"/frame*.txt 2>/dev/null) ]]; then
        animate_frames
        sleep 1
        clear
    fi
    
    # Display cached neofetch
    cat "$CACHE_FILE"
}

main "$@"
```

### Frame Generation
The frames are pre-generated ASCII art with embedded color codes:

```bash
# Example frame structure (frame0001.txt)
\033[1;32m    ███████╗██╗   ██╗██████╗ ██╗ ██████╗ ███╗   ██╗
\033[1;32m    ██╔════╝██║   ██║██╔══██╗██║██╔═══██╗████╗  ██║
\033[1;36m    █████╗  ██║   ██║██████╔╝██║██║   ██║██╔██╗ ██║
\033[1;36m    ██╔══╝  ██║   ██║██╔══██╗██║██║   ██║██║╚██╗██║
\033[1;35m    ██║     ╚██████╔╝██║  ██║██║╚██████╔╝██║ ╚████║
\033[1;35m    ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
\033[0m
```

## Shell Integration

### Zsh Integration
```bash
# Add to ~/.zshrc for automatic display
if [[ -n $PS1 ]]; then
    # Run animated neofetch on new terminal
    ~/.config/neofetch/animated-neofetch.sh 0.05
    clear
fi
```

### Bash Integration  
```bash
# Add to ~/.bashrc
if [[ $- == *i* ]]; then
    ~/.config/neofetch/animated-neofetch.sh 0.05
    clear
fi
```

### Fish Integration
```fish
# Add to ~/.config/fish/config.fish
if status is-interactive
    ~/.config/neofetch/animated-neofetch.sh 0.05
    clear
end
```

## Customization Options

### Animation Timing
```bash
# Fast animation (gaming/high-performance)
./animated-neofetch.sh 0.03

# Standard animation (default)  
./animated-neofetch.sh 0.05

# Slow animation (aesthetic focus)
./animated-neofetch.sh 0.08

# Very slow (presentation mode)
./animated-neofetch.sh 0.15
```

### Custom ASCII Frames
Create your own animation frames:

```bash
# Generate new frame
cat > frames_colour/custom_frame.txt << 'EOF'
\033[1;32m     ╭─────────────╮
\033[1;36m     │ CUSTOM FRAME │
\033[1;35m     ╰─────────────╯
\033[0m
EOF
```

### Color Customization
```bash
# Modify colors in config.conf
colors=(1 2 3 4 5 6 7 8)  # Full color range
colors=(2 6 4 8 8 6)      # Green/cyan focus
colors=(5 1 3 7 7 1)      # Pink/red focus
```

## Performance Optimization

### Cache Management
```bash
# Clear cache to force refresh
rm -f ~/.cache/neofetch.txt

# Check cache status
ls -la ~/.cache/neofetch.txt

# Force cache rebuild
touch ~/.config/neofetch/config.conf
```

### Memory Optimization
```bash
# Reduce information displayed
info() {
    case $1 in
        "Packages") packages="$(pacman -Q | wc -l)" ;;
        "Uptime") uptime="$(uptime -p | sed 's/up //')" ;;
        *) return ;;
    esac
}
```

### Startup Speed
```bash
# Disable animation for fast startup
if [[ "$TERM_PROGRAM" == "vscode" ]] || [[ -n "$SSH_CLIENT" ]]; then
    # Skip animation in certain contexts
    neofetch --config ~/.config/neofetch/config.conf
else
    # Full animation for regular terminal use
    ~/.config/neofetch/animated-neofetch.sh
fi
```

## Advanced Features

### Conditional Display
```bash
# Show different info based on context
get_info() {
    if [[ -n "$SSH_CLIENT" ]]; then
        info "SSH" "Remote session"
    fi
    
    if [[ "$USER" == "root" ]]; then
        info "Warning" "Running as root"
    fi
    
    if command -v nvidia-smi >/dev/null; then
        info "GPU Temp" "$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)°C"
    fi
}
```

### Dynamic ASCII Selection
```bash
# Choose ASCII based on hostname or time
select_ascii() {
    local hour=$(date +%H)
    
    if [[ $hour -ge 6 && $hour -lt 12 ]]; then
        ascii_source="morning_ascii.txt"
    elif [[ $hour -ge 12 && $hour -lt 18 ]]; then
        ascii_source="day_ascii.txt"  
    else
        ascii_source="night_ascii.txt"
    fi
}
```

### Integration with System Events
```bash
# Show special frames on specific events
check_special_events() {
    if [[ $(date +%m%d) == "1031" ]]; then
        FRAMES_DIR="$SCRIPT_DIR/frames_halloween"
    elif [[ $(date +%m%d) == "1225" ]]; then
        FRAMES_DIR="$SCRIPT_DIR/frames_christmas"
    fi
}
```

## Troubleshooting

### Common Issues

**Animation not showing:**
```bash
# Check frame files exist
ls ~/.config/neofetch/frames_colour/

# Verify script permissions
chmod +x ~/.config/neofetch/animated-neofetch.sh
```

**Colors not displaying:**
```bash
# Test terminal color support
echo -e "\033[1;32mGreen\033[0m \033[1;36mCyan\033[0m \033[1;35mMagenta\033[0m"

# Check TERM variable
echo $TERM
```

**Slow performance:**
```bash
# Clear old cache
rm -f ~/.cache/neofetch.txt

# Reduce frame count
cd ~/.config/neofetch/frames_colour/
mkdir backup
mv frame00{30..47}.txt backup/
```

**Information not updating:**
```bash
# Force cache refresh
touch ~/.config/neofetch/config.conf

# Manual cache clear
rm ~/.cache/neofetch.txt
```

### Performance Tuning

**For slow systems:**
```bash
# Reduce animation frames
# Keep only every 3rd frame for faster animation
cd frames_colour/
mkdir reduced/
cp frame00{01,04,07,10,13,16,19,22,25,28,31,34,37,40,43,46}.txt reduced/
```

**For fast systems:**
```bash
# Add more detailed information
info "CPU Usage" cpu_usage
info "Load Average" loadavg  
info "Network" network
info "Local IP" local_ip
```

## Creating Custom Frames

### Frame Design Guidelines
1. **Consistent dimensions** - Keep all frames the same size
2. **Color progression** - Use smooth color transitions
3. **Readable timing** - Test animation speed for readability
4. **Terminal compatibility** - Test on different terminal emulators

### Frame Generation Script
```bash
#!/bin/bash
# Generate custom animation frames

generate_frame() {
    local frame_num=$1
    local color_code=$2
    
    cat > "frames_colour/frame$(printf "%04d" $frame_num).txt" << EOF
\033[1;${color_code}m
    ┌─────────────────────┐
    │   FRAME ${frame_num}         │
    │   Custom Animation  │
    └─────────────────────┘
\033[0m
EOF
}

# Generate 20 frames with cycling colors
for i in {1..20}; do
    color=$((32 + (i % 6)))  # Cycle through colors 32-37
    generate_frame $i $color
done
```

## Dependencies

### Required Packages
```bash
# Core neofetch
sudo pacman -S neofetch

# Shell integration
sudo pacman -S zsh bash fish  # Choose your shell

# Optional utilities
sudo pacman -S fastfetch     # Faster alternative
sudo pacman -S screenfetch   # Alternative info tool
```

### Optional Enhancements
```bash
# Image display support
sudo pacman -S imagemagick w3m

# Additional system info
sudo pacman -S lm-sensors hwinfo

# Color utilities
sudo pacman -S coreutils grep sed
```

---

<div align="center">

![Neofetch Static](../../assets/demo-neofetch.png)

**Part of the Dionysus desktop environment**

*System information with cyberpunk flair*

*Note: Cache management optimizes performance - remember to clear cache after configuration changes*

</div>
