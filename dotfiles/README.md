# Dionysus Configuration Files

<div align="center">

```
                  ) ) )                     ) ) )
                ( ( (                      ( ( (
              ) ) )                       ) ) )
           (~~~~~~~~~)                 (~~~~~~~~~)
            |   А   |                   |   Б   |
            |       |                   |       |
            I      _._                  I       _._
            I    /'   `\                I     /'   `\
            I   |   N   |               I    |   N   |
            f   |   |~~~~~~~~~~~~~~|    f    |    |~~~~~~~~~~~~~~|
          .'    |   ||~~~~~~~~|    |  .'     |    | |~~~~~~~~|   |
        /'______|___||__###___|____|/'_______|____|_|__###___|___|
```

**Добро пожаловать, командир.**

*Core configuration files for the Dionysus desktop environment*

</div>

## Overview

This directory contains all configuration files for the Dionysus Hyprland rice. Each subdirectory represents a specific component of the desktop environment, carefully tuned to work together seamlessly.

## Directory Structure

```
dotfiles/
├── alacritty/                  # Terminal Emulator
│   ├── alacritty.toml         # Main configuration
│   └── README.md              # Terminal setup guide
├── cava/                      # Audio Visualizer
│   ├── config                 # Cava configuration
│   ├── shaders/               # Custom visualization shaders
│   │   ├── bar_spectrum.frag
│   │   ├── northern_lights.frag
│   │   ├── pass_through.vert
│   │   ├── spectrogram.frag
│   │   └── winamp_line_style_spectrum.frag
│   └── README.md              # Visualizer setup guide
├── eww/                       # System Widgets & HUD
│   ├── eww.yuck               # Widget definitions
│   ├── eww.scss               # Styling
│   ├── eww-state.yml          # State management
│   ├── scripts/               # System monitoring scripts
│   │   ├── ascii/             # ASCII art generators
│   │   ├── audio/             # Audio processing
│   │   ├── bar/               # Progress bars
│   │   ├── net/               # Network monitoring
│   │   └── sys/               # System statistics
│   ├── windows/               # Widget window definitions
│   │   ├── ascii/             # ASCII-based widgets
│   │   ├── bar/               # System bars
│   │   ├── misc/              # Miscellaneous widgets
│   │   ├── net/               # Network widgets
│   │   └── sys/               # System widgets
│   └── README.md              # HUD setup guide
├── firefox/                   # Browser Theme
│   ├── theme.zip              # Custom Firefox theme
│   └── README.md              # Browser customization guide
├── hypr/                      # Window Manager
│   ├── hyprland.conf          # Main Hyprland configuration
│   ├── hyprpaper.conf         # Wallpaper configuration
│   ├── hypr.log               # Runtime logs
│   ├── extras/                # Additional resources
│   │   ├── ascii_boot.txt     # Boot ASCII art
│   │   └── quotes.txt         # Inspirational quotes
│   ├── scripts/               # Automation scripts
│   │   ├── refresh-eww.sh     # Widget refresh script
│   │   ├── waybar_watcher.sh  # Bar management
│   │   └── asus-kbd/          # ASUS laptop specific
│   ├── shaders/               # Window effects
│   │   └── screenshot_overlay.frag
│   ├── wallpapers/            # Background images
│   │   ├── bg_wallpaper.png
│   │   └── black.png
│   └── README.md              # Window manager setup guide
├── neofetch/                  # System Information
│   ├── config.conf            # Neofetch configuration
│   ├── myascii.txt            # Custom ASCII art
│   ├── animated-neofetch.sh   # Animation script
│   ├── frames_colour/         # Animation frames (47 frames)
│   │   ├── frame0001.txt
│   │   ├── frame0002.txt
│   │   └── ...                # Additional frames
│   └── README.md              # Neofetch setup guide
├── rofi/                      # Application Launcher
│   ├── config.rasi            # Main configuration
│   ├── theme.rasi             # Custom theme
│   ├── image.png              # Background image
│   └── README.md              # Launcher setup guide
├── waybar/                    # Status Bar
│   ├── config                 # Main configuration
│   ├── style.css              # Styling
│   ├── scripts/               # Module scripts
│   │   ├── asus-profile.sh    # Performance profiles
│   │   ├── battery.sh         # Battery monitoring
│   │   ├── bluetooth-toggle.sh # Bluetooth control
│   │   ├── brightness-toggle.sh # Display brightness
│   │   ├── brightness.sh      # Brightness management
│   │   ├── mic.sh             # Microphone control
│   │   ├── nordvpn-status.sh  # VPN status
│   │   ├── nordvpn-toggle.sh  # VPN control
│   │   ├── powermenu.sh       # Power options
│   │   ├── volume.sh          # Audio control
│   │   └── workspaces/        # Workspace management
│   │       ├── workspace-1.sh
│   │       ├── workspace-2.sh
│   │       ├── workspace-3.sh
│   │       └── workspace-4.sh
│   └── README.md              # Status bar setup guide
└── zsh/                       # Shell Configuration
    └── README.md              # Shell setup guide
```

## Component Overview

### 🖥️ **Hyprland** - Window Manager
The core of the desktop environment, providing smooth Wayland compositing with advanced window management, animations, and workspace handling.

### 📊 **Waybar** - Status Bar  
Comprehensive system status display with interactive modules for workspaces, system monitoring, network status, and quick controls.

### 🎛️ **EWW** - System Widgets
Advanced system monitoring HUD with real-time ASCII visualizations, sensor data, and performance metrics.

### 💻 **Alacritty** - Terminal Emulator
High-performance GPU-accelerated terminal with custom theming matching the overall aesthetic.

### 🎵 **Cava** - Audio Visualizer
Real-time audio visualization with custom shaders and ASCII output for integration with system widgets.

### 🚀 **Rofi** - Application Launcher
Elegant application launcher and power menu with custom theming and smooth animations.

### 🎭 **Neofetch** - System Information
Animated system information display with custom ASCII art and color-coded system statistics.

### 🌐 **Firefox** - Browser Theme
Custom browser theme matching the neon-radioactive color palette for a cohesive desktop experience.

### 🐚 **Zsh** - Shell Configuration
Optimized shell environment with custom aliases, functions, and integrations for the desktop environment.

## Installation Workflow

1. **Base Setup**: Copy all configuration files to `~/.config/`
2. **Permissions**: Make all scripts executable
3. **Dependencies**: Install required packages
4. **Activation**: Launch Hyprland and enjoy

## Customization Philosophy

Each component follows the **neon-radioactive** design language:
- **Dark backgrounds** with electric accents
- **Monospace fonts** for technical aesthetics  
- **ASCII art integration** for cyberpunk vibes
- **Performance optimization** for smooth experience
- **Modular design** for easy customization

## Integration Points

- **Cava** outputs to `/tmp/cava.raw` for EWW consumption
- **System scripts** provide real-time data to Waybar and EWW
- **Color palette** is consistent across all components
- **Font choices** maintain visual coherence
- **Animation timing** is synchronized between components

---

<div align="center">

*Each component is documented individually for detailed configuration options*

</div>


