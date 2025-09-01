# Hyprland Window Manager Configuration

<div align="center">

![Hyprland Demo](../../assets/demo-hypr.gif)

**Advanced Wayland compositor optimized for the Dionysus desktop environment**

</div>

## Overview

This Hyprland configuration serves as the foundation of the Dionysus desktop environment, providing smooth Wayland compositing, intelligent window management, and seamless integration with all system components.

## Files Structure

```
hypr/
├── hyprland.conf              # Main Hyprland configuration
├── hyprpaper.conf             # Wallpaper daemon configuration  
├── hypr.log                   # Runtime logs and debugging
├── extras/                    # Additional resources
│   ├── ascii_boot.txt         # Boot ASCII art display
│   └── quotes.txt             # Inspirational quotes collection
├── scripts/                   # Automation and utility scripts
│   ├── refresh-eww.sh         # EWW widget refresh utility
│   ├── waybar_watcher.sh      # Status bar management daemon
│   └── asus-kbd/              # ASUS laptop keyboard utilities
│       ├── kbd-brightness.sh  # Keyboard backlight control
│       ├── kbd-breathing.sh   # Breathing light effects
│       └── cycle-profile.sh   # Performance profile cycling
├── shaders/                   # Visual effects and overlays
│   └── screenshot_overlay.frag # Screenshot highlight shader
├── wallpapers/                # Background images
│   ├── bg_wallpaper.png       # Primary desktop wallpaper
│   └── black.png              # Fallback solid background
└── README.md                  # This documentation
```

## Core Features

### 🖥️ Window Management
- **Intelligent tiling** with automatic layout optimization
- **Floating window** support with precise positioning
- **Multi-workspace** management (4 primary workspaces)
- **Smooth animations** for all window operations
- **Focus-follows-mouse** with customizable behavior

### 🎨 Visual Effects
- **Blur effects** for transparent windows
- **Drop shadows** with configurable opacity
- **Rounded corners** for modern aesthetics
- **Border highlighting** for active windows
- **Fade animations** for window transitions

### ⚡ Performance Optimization
- **GPU acceleration** for all rendering operations
- **VFR (Variable Frame Rate)** for power efficiency
- **Optimized rendering** for high refresh rate displays
- **Memory-efficient** window handling
- **Hardware-accelerated** video playback

### 🔧 Hardware Integration
- **ASUS laptop** specific optimizations
- **Keyboard backlight** management
- **Performance profile** switching
- **Temperature monitoring** integration
- **Power management** awareness

## Configuration Highlights

### Window Rules
```bash
# Terminal transparency
windowrule = opacity 0.95,^(Alacritty)$
windowrule = opacity 0.95,^(alacritty)$

# Firefox optimizations  
windowrule = opacity 0.98,^(firefox)$
windowrule = animation slide,^(firefox)$

# File manager rules
windowrule = float,^(thunar)$
windowrule = size 800 600,^(thunar)$

# EWW widgets positioning
windowrule = pin,^(eww)$
windowrule = noblur,^(eww)$
windowrule = noshadow,^(eww)$
```

### Key Bindings

#### Window Management
| Key Combination | Action | Description |
|-----------------|--------|-------------|
| `Super + Q` | `killactive` | Close active window |
| `Super + M` | `exit` | Exit Hyprland session |
| `Super + E` | `exec, thunar` | Open file manager |
| `Super + V` | `togglefloating` | Toggle floating mode |
| `Super + Space` | `exec, rofi -show drun` | Launch application |
| `Super + P` | `pseudo` | Enter pseudo-tiling mode |
| `Super + J` | `togglesplit` | Toggle split direction |

#### Workspace Navigation
| Key Combination | Action | Description |
|-----------------|--------|-------------|
| `Super + 1-4` | `workspace 1-4` | Switch to workspace 1-4 |
| `Super + Shift + 1-4` | `movetoworkspace 1-4` | Move window to workspace |
| `Super + Tab` | `cyclenext` | Cycle through windows |
| `Super + Shift + Tab` | `cyclenext prev` | Cycle backwards |

#### System Controls
| Key Combination | Action | Description |
|-----------------|--------|-------------|
| `Super + Return` | `exec, alacritty` | Launch terminal |
| `Print` | `exec, grim` | Take screenshot |
| `Shift + Print` | `exec, grim -g "$(slurp)"` | Area screenshot |
| `Super + L` | `exec, swaylock` | Lock screen |

#### Audio Controls
| Key Combination | Action | Description |
|-----------------|--------|-------------|
| `XF86AudioRaiseVolume` | `exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+` | Increase volume |
| `XF86AudioLowerVolume` | `exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-` | Decrease volume |
| `XF86AudioMute` | `exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle` | Toggle mute |

#### Brightness Controls
| Key Combination | Action | Description |
|-----------------|--------|-------------|
| `XF86MonBrightnessUp` | `exec, brightnessctl set 10%+` | Increase brightness |
| `XF86MonBrightnessDown` | `exec, brightnessctl set 10%-` | Decrease brightness |

### Input Configuration
```bash
input {
    kb_layout = us
    kb_variant = 
    kb_model =
    kb_options =
    kb_rules =
    
    follow_mouse = 1
    
    touchpad {
        natural_scroll = true
        tap-to-click = true
        drag_lock = true
        disable_while_typing = true
    }
    
    sensitivity = 0.2
    accel_profile = adaptive
}
```

### Visual Effects Configuration
```bash
decoration {
    rounding = 8
    
    blur {
        enabled = true
        size = 6
        passes = 3
        new_optimizations = true
        ignore_opacity = true
    }
    
    drop_shadow = true
    shadow_range = 20
    shadow_render_power = 3
    col.shadow = rgba(39ff1480)
    col.shadow_inactive = rgba(00000080)
}
```

### Animation Settings
```bash
animations {
    enabled = true
    
    bezier = ease-out, 0.25, 1, 0.5, 1
    bezier = ease-in-out, 0.42, 0, 0.58, 1
    bezier = linear, 0, 0, 1, 1
    
    animation = windows, 1, 7, ease-out
    animation = windowsOut, 1, 7, ease-in-out, popin 80%
    animation = border, 1, 10, ease-out
    animation = borderangle, 1, 8, ease-out
    animation = fade, 1, 7, ease-out
    animation = workspaces, 1, 6, ease-out
}
```

## Auto-Start Configuration

### Essential Services
```bash
# Core desktop components
exec-once = waybar &
exec-once = hyprpaper &
exec-once = ~/.config/hypr/scripts/waybar_watcher.sh &

# Audio and visualization
exec-once = cava -p ~/.config/cava/config &
exec-once = ~/.config/eww/scripts/audio/audio_visualizer.py &

# System widgets
exec-once = eww daemon &
exec-once = ~/.config/hypr/scripts/refresh-eww.sh &

# Applications
exec-once = firefox &
exec-once = thunar --daemon &

# System services
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
exec-once = wl-paste --type text --watch cliphist store &
exec-once = wl-paste --type image --watch cliphist store &
```

## Script Documentation

### Waybar Watcher (`waybar_watcher.sh`)
```bash
#!/bin/bash
# Monitors and manages Waybar and EWW processes
# Ensures components stay running and restart if needed

monitor_waybar() {
    while true; do
        if ! pgrep -x waybar > /dev/null; then
            echo "Restarting Waybar..."
            waybar &
        fi
        sleep 10
    done
}

monitor_eww() {
    while true; do
        if ! pgrep -x eww > /dev/null; then
            echo "Restarting EWW daemon..."
            eww daemon &
            sleep 2
            ~/.config/hypr/scripts/refresh-eww.sh &
        fi
        sleep 15
    done
}

# Run monitoring functions in background
monitor_waybar &
monitor_eww &
```

### EWW Refresh Script (`refresh-eww.sh`)
```bash
#!/bin/bash
# Refreshes EWW widgets and ensures proper startup

# Wait for EWW daemon
sleep 3

# Close any existing widgets
eww close-all

# Launch all HUD components
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

### ASUS Keyboard Scripts

**Brightness Control (`kbd-brightness.sh`)**
```bash
#!/bin/bash
# Control ASUS keyboard backlight brightness

BRIGHTNESS_FILE="/sys/class/leds/asus::kbd_backlight/brightness"
MAX_BRIGHTNESS=$(cat /sys/class/leds/asus::kbd_backlight/max_brightness)

case $1 in
    up)
        current=$(cat $BRIGHTNESS_FILE)
        new=$((current + 1))
        if [ $new -le $MAX_BRIGHTNESS ]; then
            echo $new | sudo tee $BRIGHTNESS_FILE
        fi
        ;;
    down)
        current=$(cat $BRIGHTNESS_FILE)
        new=$((current - 1))
        if [ $new -ge 0 ]; then
            echo $new | sudo tee $BRIGHTNESS_FILE
        fi
        ;;
    *)
        echo "Usage: $0 {up|down}"
        ;;
esac
```

**Breathing Effect (`kbd-breathing.sh`)**
```bash
#!/bin/bash
# Toggle ASUS keyboard breathing effect

EFFECT_FILE="/sys/devices/platform/asus-nb-wmi/leds/asus::kbd_backlight/breathing"

if [ -f $EFFECT_FILE ]; then
    current=$(cat $EFFECT_FILE)
    if [ "$current" = "1" ]; then
        echo 0 | sudo tee $EFFECT_FILE
        notify-send "Keyboard" "Breathing effect disabled"
    else
        echo 1 | sudo tee $EFFECT_FILE
        notify-send "Keyboard" "Breathing effect enabled"
    fi
else
    notify-send "Error" "Breathing effect not supported"
fi
```

**Performance Profile Cycling (`cycle-profile.sh`)**
```bash
#!/bin/bash
# Cycle through ASUS performance profiles

PROFILE_FILE="/sys/firmware/acpi/platform_profile"

if [ -f $PROFILE_FILE ]; then
    current=$(cat $PROFILE_FILE)
    
    case $current in
        "performance")
            echo "balanced" | sudo tee $PROFILE_FILE
            notify-send "Performance" "Switched to Balanced mode"
            ;;
        "balanced")
            echo "power-saver" | sudo tee $PROFILE_FILE
            notify-send "Performance" "Switched to Power Saver mode"
            ;;
        "power-saver")
            echo "performance" | sudo tee $PROFILE_FILE
            notify-send "Performance" "Switched to Performance mode"
            ;;
    esac
else
    notify-send "Error" "Performance profiles not available"
fi
```

## Hyprpaper Configuration

### Wallpaper Setup (`hyprpaper.conf`)
```bash
preload = ~/.config/hypr/wallpapers/bg_wallpaper.png
preload = ~/.config/hypr/wallpapers/black.png

wallpaper = DP-1,~/.config/hypr/wallpapers/bg_wallpaper.png
wallpaper = HDMI-A-1,~/.config/hypr/wallpapers/bg_wallpaper.png

splash = false
ipc = true
```

## Monitor Configuration

### Multi-Monitor Setup
```bash
# Primary monitor (internal laptop display)
monitor = eDP-1, 1920x1080@165, 0x0, 1

# External monitor (if connected)  
monitor = DP-1, 2560x1440@144, 1920x0, 1
monitor = HDMI-A-1, 1920x1080@60, 4480x0, 1

# Fallback for unknown monitors
monitor = , preferred, auto, 1
```

### Workspace-to-Monitor Binding
```bash
workspace = 1, monitor:eDP-1
workspace = 2, monitor:eDP-1  
workspace = 3, monitor:DP-1
workspace = 4, monitor:DP-1
```

## Advanced Features

### Window Swallowing
```bash
# Terminal window swallowing for GUI applications
windowrule = noinitialfocus,^(alacritty)$
misc {
    enable_swallow = true
    swallow_regex = ^(Alacritty)$
}
```

### Special Workspace Rules
```bash
# Scratchpad workspace
bind = Super, S, togglespecialworkspace, scratchpad
bind = Super_Shift, S, movetoworkspace, special:scratchpad

# Floating workspace for quick access
workspace = special:floating, gapsout:50
```

### Gaming Optimizations
```bash
# Game-specific rules
windowrule = immediate,^(steam_app_)
windowrule = fullscreen,^(steam_app_)
windowrule = noborder,^(steam_app_)
windowrule = noshadow,^(steam_app_)

# Performance mode for games
misc {
    vfr = false  # Disable VFR for gaming
    vrr = 2      # Enable VRR for supported displays
}
```

## Troubleshooting

### Common Issues

**Hyprland won't start:**
```bash
# Check logs
cat ~/.local/share/hyprland/hyprland.log

# Test configuration
hyprland --config ~/.config/hypr/hyprland.conf
```

**Screen tearing:**
```bash
# Enable VSync
misc {
    no_vfr = false
    vrr = 1
}
```

**Input devices not working:**
```bash
# List input devices
hyprctl devices

# Reload input configuration
hyprctl reload
```

**Window rules not applying:**
```bash
# Debug window properties
hyprctl clients | grep -A 10 "Window"

# Test window rules
hyprctl keyword windowrule "float,^(test)$"
```

### Performance Tuning

**For lower-end hardware:**
```bash
# Reduce animations
animations {
    enabled = false
}

# Disable blur
decoration {
    blur {
        enabled = false
    }
}
```

**For high-end systems:**
```bash
# Enable additional features
misc {
    vfr = true
    vrr = 2
}

# Higher quality blur
decoration {
    blur {
        size = 10
        passes = 4
    }
}
```

## Dependencies

### Required Packages
```bash
# Core Hyprland
sudo pacman -S hyprland hyprpaper

# Essential utilities
sudo pacman -S waybar rofi-wayland alacritty

# Screenshot and clipboard
sudo pacman -S grim slurp wl-clipboard

# Audio and brightness
sudo pacman -S wpctl brightnessctl playerctl

# File manager and browser
sudo pacman -S thunar firefox

# Authentication and notifications
sudo pacman -S polkit-gnome libnotify
```

### Optional Enhancements
```bash
# Screen locking
sudo pacman -S swaylock-effects

# App launcher alternatives
sudo pacman -S wofi fuzzel

# Additional utilities
sudo pacman -S cliphist wl-clip-persist
```

## Integration Points

### With EWW Widgets
- Window focus triggers widget updates
- Workspace changes reflected in HUD
- System stats integration through scripts

### With Waybar
- Workspace indicators synchronized
- Window titles displayed in bar
- System tray integration

### With Cava
- Audio visualization overlays
- Workspace-specific visualizer positioning
- Performance mode awareness

---

<div align="center">

![Hyprland Demo 2](../../assets/demo-hypr-2.gif)

**Part of the Dionysus desktop environment**

*The foundation of a cyberpunk workstation*

</div>
