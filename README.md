# Dionysus Dotfiles

Welcome to Dionysus Dotfiles, a curated collection of configurations for various applications. This repository aims to provide a consistent and aesthetically pleasing user experience across different environments, with a focus on a Nord-inspired, neon-accented theme.

## Overview

This repository contains dotfiles for a range of tools, from terminal emulators to window managers. Each set of dotfiles is designed to be modular and easy to customize, allowing you to pick and choose the configurations that best suit your workflow.

## Usage

To use these dotfiles, you can clone the repository and then symlink the desired configuration files to your home directory. For example, to use the Alacritty configuration, you would run the following command:

```bash
# Example for Alacritty:
# Make sure to create the target directory if it doesn't exist
mkdir -p ~/.config/alacritty
# Create the symlink
ln -s "$(pwd)/dotfiles/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml```
```
## Table of Contents

*   [Alacritty](./dotfiles/alacritty/README.md)
*   [Cava](./dotfiles/cava/README.md)
*   [Eww](./dotfiles/eww/README.md)
*   [Firefox](./dotfiles/firefox/README.md)
*   [Hypr](./dotfiles/hypr/README.md)
*   [Neofetch](./dotfiles/neofetch/README.md)
*   [Rofi](./dotfiles/rofi/README.md)
*   [Waybar](./dotfiles/waybar/README.md)
*   [Zsh](./dotfiles/zsh/.zshrc)
