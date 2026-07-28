# Dionysus — dotfiles and demo assets
 
Dionysus is a curated collection of desktop dotfiles, themes, and demo assets for Linux Wayland-based setups (Hyprland, Waybar, Alacritty, etc.), intended for users who want a ready-made, configurable desktop environment.
 
## What this repo contains
 
- **`assets/`** — screenshots and animated demos used for presentation (GIFs, PNGs)
- **`dotfiles/`** — organized configuration for desktop components:
  - `alacritty/` — Alacritty terminal config and theme
  - `cava/` — audio visualizer configuration
  - `eww/` — Eww widget configs
  - `firefox/` — Firefox tweaks and user.js
  - `hypr/` — Hyprland configuration
  - `neofetch/` — Neofetch theme and config
  - `rofi/` — Rofi launcher configs and themes
  - `waybar/` — Waybar status bar configs and modules
  - `zsh/` — Zsh configuration and plugins
## Quick start
 
1. Fork the repository and clone your fork:
```bash
   git clone https://github.com/<your-username>/dionysus.git
   cd dionysus
```
 
2. Inspect the component you want to try, e.g. Alacritty:
```bash
   less dotfiles/alacritty/alacritty.toml
```
 
3. To test a config locally, copy or symlink it into your home config directory. Example (Alacritty):
```bash
   mkdir -p ~/.config/alacritty
   cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
```
 
> **Always review files before overwriting anything in your home directory.**
 
**Note:** There is currently no automated installer included. If you'd like an install script, open an issue or submit a PR.
 
## Viewing demos
 
The `assets/` directory contains demo images and animated GIFs. Many are large — view PNG thumbnails on GitHub for a quick preview, or download smaller previews when available.
 
Examples:
 
- `assets/demo-neofetch.png`
- `assets/demo-hypr.gif`
If you add new large assets, ask maintainers if Git LFS is preferred.
 
## Contributing
 
Contributions are welcome. Suggested first PRs:
 
- Fix typos and improve consistency in config files.
- Add safe, idempotent install/symlink scripts with a clear uninstall option.
- Optimize large demo assets or add lightweight preview images.
