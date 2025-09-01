# Alacritty Terminal Configuration

<div align="center">

![Alacritty Demo](../../assets/demo-alacritty.png)

**High-performance terminal with neon-radioactive theming**

</div>

## Overview

This configuration transforms Alacritty into a cyberpunk-inspired terminal that perfectly integrates with the Dionysus desktop environment. The setup emphasizes performance, readability, and aesthetic consistency.

## Files Structure

```
alacritty/
├── alacritty.toml              # Main configuration file
└── README.md                   # This documentation
```

## Configuration Highlights

### Performance Optimizations
- **GPU acceleration** enabled for smooth rendering
- **Optimized font rendering** with proper hinting
- **Efficient scrollback** buffer management
- **Hardware cursor** for reduced latency

### Visual Design
- **Nord-inspired color palette** with electric accents
- **JetBrains Mono** font for optimal code readability
- **Transparent background** for depth and style
- **Custom cursor styling** matching the theme

### Key Features
- **Font ligatures** support for modern coding symbols
- **Smooth scrolling** with configurable speed
- **Dynamic title** updates based on running commands
- **Copy/paste** optimizations for Wayland

## Color Palette

The terminal uses the signature **neon-radioactive** color scheme:

```toml
[colors.primary]
background = "#0a0a0f"          # Deep navy background
foreground = "#7dcfff"          # Electric blue text

[colors.normal]
black   = "#1a1a2e"             # Dark slate
red     = "#ff6b6b"             # Soft red
green   = "#39ff14"             # Neon green
yellow  = "#ffff00"             # Radioactive yellow
blue    = "#7dcfff"             # Electric blue
magenta = "#ff1493"             # Cyber pink
cyan    = "#00ffff"             # Bright cyan
white   = "#ffffff"             # Pure white

[colors.bright]
black   = "#2a2a3e"             # Lighter slate
red     = "#ff8080"             # Bright red
green   = "#66ff66"             # Bright green
yellow  = "#ffff66"             # Bright yellow
blue    = "#99d6ff"             # Bright blue
magenta = "#ff66b3"             # Bright magenta
cyan    = "#66ffff"             # Bright cyan
white   = "#ffffff"             # Bright white
```

## Font Configuration

```toml
[font]
normal = { family = "JetBrains Mono", style = "Regular" }
bold = { family = "JetBrains Mono", style = "Bold" }
italic = { family = "JetBrains Mono", style = "Italic" }
bold_italic = { family = "JetBrains Mono", style = "Bold Italic" }

size = 12.0
```

### Font Features
- **Programming ligatures** for enhanced code readability
- **Consistent character width** for perfect alignment
- **Clear distinction** between similar characters (0/O, 1/l/I)
- **Optimal size** for various screen densities

## Window Settings

```toml
[window]
opacity = 0.95                  # Slight transparency
padding = { x = 8, y = 8 }      # Comfortable padding
decorations = "none"            # Clean borderless look
startup_mode = "Windowed"       # Default window mode
dynamic_title = true            # Update title with current command
```

## Keybindings

Custom keybindings optimized for the Hyprland workflow:

| Key Combination | Action | Description |
|-----------------|--------|-------------|
| `Ctrl + Shift + C` | Copy | Copy selected text |
| `Ctrl + Shift + V` | Paste | Paste from clipboard |
| `Ctrl + Shift + N` | New Window | Open new terminal window |
| `Ctrl + Plus` | Increase Font | Make text larger |
| `Ctrl + Minus` | Decrease Font | Make text smaller |
| `Ctrl + 0` | Reset Font | Return to default size |

## Integration with Hyprland

The terminal is configured to work seamlessly with the window manager:

- **Window rules** defined in `hyprland.conf` for proper handling
- **Transparency** that respects compositor settings
- **Focus behavior** optimized for tiling workflows
- **Startup commands** for immediate availability

## Usage Tips

### Launch Commands
```bash
# Standard terminal
alacritty

# With specific command
alacritty -e nvim

# With working directory
alacritty --working-directory ~/projects

# Fullscreen mode
alacritty --option window.startup_mode=Fullscreen
```

### Customization Options

1. **Adjust opacity** for different lighting conditions
2. **Modify font size** based on screen size and preference
3. **Customize colors** while maintaining theme consistency
4. **Add keybindings** for personal workflow optimization

## Dependencies

### Required Packages
```bash
# Core terminal
sudo pacman -S alacritty

# Recommended font
sudo pacman -S ttf-jetbrains-mono

# For full functionality
sudo pacman -S wl-clipboard      # Wayland clipboard support
```

### Optional Enhancements
```bash
sudo pacman -S ttf-nerd-fonts-symbols  # Icon support
sudo pacman -S bat                      # Better cat with syntax highlighting
sudo pacman -S exa                      # Modern ls replacement
sudo pacman -S zsh                      # Enhanced shell
```

## Troubleshooting

### Common Issues

**Font not rendering correctly:**
```bash
# Refresh font cache
fc-cache -fv
```

**Transparency not working:**
- Ensure compositor (Hyprland) supports transparency
- Check window opacity settings in configuration

**Performance issues:**
- Disable unnecessary visual effects
- Reduce scrollback buffer size
- Check GPU driver installation

### Performance Tuning

For optimal performance on various hardware:

```toml
[scrolling]
history = 10000                 # Adjust based on memory
multiplier = 3                  # Scroll speed

[cursor]
vi_mode_style = "Block"         # Visible cursor in vi mode
unfocused_hollow = true         # Hollow cursor when unfocused
```

## Advanced Configuration

### Custom Shell Integration

The terminal works best with the configured Zsh environment:

```bash
# Add to ~/.zshrc for enhanced experience
export TERM="alacritty"
export COLORTERM="truecolor"
```

### Theme Variants

Create different configurations for various use cases:

```bash
# Development theme (higher contrast)
alacritty --config-file ~/.config/alacritty/dev.toml

# Presentation theme (larger font)
alacritty --config-file ~/.config/alacritty/presentation.toml
```

---

<div align="center">

**Part of the Dionysus desktop environment**

*Optimized for productivity and visual appeal*

</div>
