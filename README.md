# Dionysus Dotfiles

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

*A comprehensive Hyprland rice configuration for Arch Linux*

![Hyprland Demo](assets/demo.gif)

</div>

## Overview

Dionysus is a meticulously crafted desktop environment configuration featuring a Nord-inspired neon-radioactive theme. Built for **Hyprland** on **Arch Linux**, this configuration transforms your **ROG Zephyrus G15** (or any compatible system) into a cyberpunk command center.

### Core Features

- **🎭 Animated Neofetch** - Dynamic ASCII art with smooth transitions
- **📊 Dynamic Waybar** - Intelligent status bar with contextual modules  
- **🎵 ASCII Cava Visualizer** - Real-time audio visualization in terminal
- **🎨 Neon-Radioactive Theme** - Nord-inspired with electric accents
- **⚡ Performance Optimized** - Lightweight and responsive configuration

## Project Structure

```
dionysus/
├── README.md                    # This file
├── assets/                     # Screenshots and demos
│   ├── demo.gif                # Main demonstration
│   ├── demo-*.png              # Component screenshots
│   └── demo-*.gif              # Animated demos
└── dotfiles/                   # Configuration files
    ├── alacritty/              # Terminal emulator
    ├── cava/                   # Audio visualizer
    ├── eww/                    # System widgets and HUD
    ├── firefox/                # Browser theme
    ├── hypr/                   # Window manager
    ├── neofetch/               # System information display
    ├── rofi/                   # Application launcher
    ├── waybar/                 # Status bar
    └── zsh/                    # Shell configuration
```

## Component Showcase

<details>
<summary><strong>🖥️ Hyprland Window Manager</strong></summary>

![Hyprland Demo](assets/demo-hypr.gif)
![Hyprland Demo 2](assets/demo-hypr-2.gif)

Dynamic window management with smooth animations and intelligent workspace handling.
</details>

<details>
<summary><strong>🎭 Animated Neofetch</strong></summary>

![Neofetch Demo](assets/demo-neofetch.gif)
![Neofetch Static](assets/demo-neofetch.png)

Custom animated system information display with cyberpunk aesthetics.
</details>

<details>
<summary><strong>🎛️ EWW System HUD</strong></summary>

![EWW HUD](assets/demo-eww.png)
![EWW Demo](assets/demo-eww.gif)

Real-time system monitoring with ASCII art visualizations and sensor data.
</details>

<details>
<summary><strong>🚀 Rofi Application Launcher</strong></summary>

![Rofi Demo](assets/demo-rofi.png)
![Rofi Demo 2](assets/demo-rofi-2.png)

Sleek application launcher with power menu integration.
</details>

<details>
<summary><strong>🎵 Cava Audio Visualizer</strong></summary>

![Cava Demo](assets/demo-cava.gif)
![Cava Demo 2](assets/demo-cava-2.gif)

ASCII-based audio visualization integrated with system widgets.
</details>

<details>
<summary><strong>📊 Waybar Status Bar</strong></summary>

![Waybar Demo](assets/demo-waybar.png)
![Waybar Demo 2](assets/demo-waybar-2.png)
![Waybar Demo 3](assets/demo-waybar-2_1.png)

Comprehensive system status with interactive modules and dynamic updates.
</details>

<details>
<summary><strong>💻 Alacritty Terminal</strong></summary>

![Alacritty Demo](assets/demo-alacritty.png)

High-performance terminal with custom theming and font configurations.
</details>

## Theme Palette

The **Neon-Radioactive** color scheme combines Nord-inspired cool tones with electric accents:

| Element | Color | Hex Code | Usage |
|---------|-------|----------|-------|
| **Background** | Deep Navy | `#0a0a0f` | Primary background |
| **Foreground** | Electric Blue | `#7dcfff` | Text and borders |
| **Accent** | Neon Green | `#39ff14` | Highlights and active states |
| **Secondary** | Radioactive Yellow | `#ffff00` | Warnings and notifications |
| **Tertiary** | Cyber Pink | `#ff1493` | Special elements |

## Quick Start

### Prerequisites

- **Arch Linux** (or compatible distribution)
- **Hyprland** and Wayland support
- **Nerd Fonts** for proper icon rendering

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/pewdiepie-archdaemon/dionysus.git
   cd dionysus
   ```

2. **Backup existing configurations**
   ```bash
   mkdir -p ~/.config.backup
   cp -r ~/.config/* ~/.config.backup/ 2>/dev/null || true
   ```

3. **Install dotfiles**
   ```bash
   cp -r dotfiles/* ~/.config/
   ```

4. **Set executable permissions**
   ```bash
   find ~/.config -name "*.sh" -exec chmod +x {} \;
   ```

5. **Install dependencies**
   ```bash
   # Core Wayland components
   sudo pacman -S hyprland hyprpaper eww-wayland cava rofi-wayland
   
   # Terminal and utilities
   sudo pacman -S alacritty waybar thunar firefox
   
   # System tools
   sudo pacman -S grim slurp wl-clipboard wpctl playerctl brightnessctl
   sudo pacman -S lm-sensors neofetch
   
   # Audio system
   sudo pacman -S pipewire pipewire-pulse pipewire-alsa
   
   # Fonts
   sudo pacman -S ttf-nerd-fonts-symbols ttf-jetbrains-mono
   ```

### Post-Installation

1. **Configure sensors**
   ```bash
   sudo sensors-detect
   ```

2. **Set Zsh as default shell** (optional)
   ```bash
   chsh -s /usr/bin/zsh
   ```

3. **Launch Hyprland**
   ```bash
   Hyprland
   ```

## Key Bindings

| Combination | Action |
|-------------|--------|
| `Super + Q` | Close active window |
| `Super + Space` | Toggle floating mode |
| `Super + Return` | Launch terminal |
| `Super + D` | Open Rofi launcher |
| `Super + Tab` | Cycle through windows |
| `Super + 1-4` | Switch to workspace 1-4 |
| `Super + Shift + 1-4` | Move window to workspace 1-4 |

## Configuration Details

Each component is modular and can be customized independently:

- **[Hyprland](dotfiles/hypr/README.md)** - Window manager configuration and scripts
- **[Waybar](dotfiles/waybar/README.md)** - Status bar modules and styling
- **[EWW](dotfiles/eww/README.md)** - System widgets and HUD components
- **[Cava](dotfiles/cava/README.md)** - Audio visualizer configuration
- **[Alacritty](dotfiles/alacritty/README.md)** - Terminal emulator theming
- **[Rofi](dotfiles/rofi/README.md)** - Application launcher styling
- **[Neofetch](dotfiles/neofetch/README.md)** - Animated system information
- **[Firefox](dotfiles/firefox/README.md)** - Browser theme integration
- **[Zsh](dotfiles/zsh/README.md)** - Shell environment setup

## Hardware Optimization

This configuration includes specific optimizations for **ASUS ROG laptops**:

- Custom keyboard brightness controls
- Performance profile cycling
- Temperature and voltage monitoring
- Fan curve management
- Power management integration

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## Resources

- [Hyprland Documentation](https://hyprland.org/)
- [EWW GitHub Repository](https://github.com/elkowar/eww)
- [Cava GitHub Repository](https://github.com/karlstav/cava)
- [Nord Theme](https://www.nordtheme.com/)
- [Arch Linux Wiki](https://wiki.archlinux.org/)

---

<div align="center">

**Built with ❤️ on Arch Linux**

*Cheers to the open source community! 🍸*

</div>
