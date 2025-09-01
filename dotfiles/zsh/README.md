# Zsh Shell Configuration

<div align="center">

**Enhanced shell environment optimized for the Dionysus desktop experience**

</div>

## Overview

This Zsh configuration provides an optimized shell environment that integrates seamlessly with the Dionysus desktop environment. It includes custom aliases, functions, and environment variables specifically designed to enhance productivity within the cyberpunk-themed setup.

## Files Structure

```
zsh/
├── .zshrc                     # Main Zsh configuration (to be copied to ~/)
├── .zsh_aliases               # Custom aliases and shortcuts
├── .zsh_functions             # Custom shell functions
├── .zsh_exports               # Environment variables
└── README.md                  # This documentation
```

## Core Features

### 🚀 Performance Optimization
- **Fast startup** with optimized plugin loading
- **Intelligent completion** system
- **History optimization** for large command histories
- **Async prompt** updates for responsiveness

### 🎨 Visual Enhancements
- **Cyberpunk prompt** matching the desktop theme
- **Syntax highlighting** for commands and paths
- **Auto-suggestions** based on history
- **Color-coded output** for better readability

### 🔧 Dionysus Integration
- **Desktop environment** specific aliases
- **System monitoring** shortcuts
- **Development workflow** optimizations
- **Custom functions** for common tasks

### ⚡ Productivity Features
- **Smart aliases** for common commands
- **Directory navigation** enhancements
- **Git integration** with status information
- **Auto-completion** for tools and applications

## Configuration Highlights

### Main Configuration (`.zshrc`)
```bash
# Dionysus Zsh Configuration
# Optimized for cyberpunk desktop environment

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins for enhanced functionality
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    command-not-found
    history-substring-search
    sudo
    extract
)

source $ZSH/oh-my-zsh.sh

# Dionysus-specific configurations
source ~/.zsh_exports
source ~/.zsh_aliases  
source ~/.zsh_functions

# History configuration
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

# Auto-completion settings
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# Auto-start animated neofetch on new terminal
if [[ -n $PS1 ]]; then
    ~/.config/neofetch/animated-neofetch.sh 0.05
    clear
fi
```

### Custom Aliases (`.zsh_aliases`)
```bash
# Dionysus Desktop Environment Aliases

# System monitoring and control
alias sys='btop'                           # System monitor
alias temp='watch sensors'                 # Temperature monitoring  
alias fans='watch "sensors | grep fan"'    # Fan speed monitoring
alias gpu='watch nvidia-smi'               # GPU monitoring
alias mem='free -h'                        # Memory usage
alias disk='df -h'                         # Disk usage

# Hyprland window manager
alias hconf='nvim ~/.config/hypr/hyprland.conf'    # Edit Hyprland config
alias hreload='hyprctl reload'                     # Reload Hyprland
alias hinfo='hyprctl clients'                      # Window information
alias hkill='hyprctl dispatch killactive'          # Kill active window

# Waybar status bar
alias wconf='nvim ~/.config/waybar/config'         # Edit Waybar config
alias wstyle='nvim ~/.config/waybar/style.css'     # Edit Waybar style
alias wrestart='pkill waybar && waybar &'          # Restart Waybar

# EWW system widgets
alias econf='nvim ~/.config/eww/eww.yuck'          # Edit EWW config
alias estyle='nvim ~/.config/eww/eww.scss'         # Edit EWW styles
alias eopen='eww open-many $(eww windows | grep "eww-" | tr "\n" " ")'  # Open all widgets
alias eclose='eww close-all'                       # Close all widgets
alias erestart='eww kill && eww daemon'            # Restart EWW

# Audio and visualization
alias cava='cava -p ~/.config/cava/config'         # Start Cava visualizer
alias vol='wpctl get-volume @DEFAULT_AUDIO_SINK@'  # Get volume
alias volup='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'    # Volume up
alias voldown='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'  # Volume down
alias mute='wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'    # Toggle mute

# Application launchers
alias launcher='rofi -show drun'                   # Application launcher
alias runner='rofi -show run'                      # Command runner
alias windows='rofi -show window'                  # Window switcher
alias power='~/.config/rofi/scripts/power-menu.sh' # Power menu

# Terminal and applications
alias term='alacritty'                             # New terminal
alias files='thunar'                               # File manager
alias browser='firefox'                            # Web browser
alias editor='nvim'                                # Text editor
alias code='code'                                  # VS Code

# Git shortcuts
alias gs='git status'                              # Git status
alias ga='git add'                                 # Git add
alias gc='git commit'                              # Git commit
alias gp='git push'                                # Git push
alias gl='git log --oneline'                       # Git log
alias gd='git diff'                                # Git diff

# Directory navigation
alias ..='cd ..'                                   # Up one directory
alias ...='cd ../..'                               # Up two directories
alias ....='cd ../../..'                           # Up three directories
alias ~='cd ~'                                     # Home directory
alias projects='cd ~/projects'                     # Projects directory
alias dotfiles='cd ~/.config'                      # Dotfiles directory
alias dionysus='cd ~/.config && find . -name "*.conf" -o -name "*.toml" -o -name "*.yuck" -o -name "*.rasi"'

# File operations
alias ls='exa --icons --group-directories-first'   # Enhanced ls
alias ll='exa -la --icons --group-directories-first'  # Long list
alias tree='exa --tree --icons'                    # Tree view
alias cp='cp -i'                                   # Interactive copy
alias mv='mv -i'                                   # Interactive move
alias rm='rm -i'                                   # Interactive remove
alias mkdir='mkdir -p'                             # Create directories recursively

# System utilities
alias grep='grep --color=auto'                     # Colored grep
alias cat='bat'                                    # Better cat with syntax highlighting
alias find='fd'                                    # Better find
alias ps='procs'                                   # Better ps
alias top='btop'                                   # Better top
alias du='dust'                                    # Better du

# Network utilities
alias ping='ping -c 5'                             # Ping with count
alias ports='netstat -tuln'                        # Show open ports
alias myip='curl -s ifconfig.me'                   # External IP
alias localip='ip route get 1 | awk "{print \$7}"' # Local IP
alias wifi='nmcli dev wifi'                        # WiFi networks
alias vpn='nordvpn status'                         # VPN status

# Package management (Arch Linux)
alias install='sudo pacman -S'                     # Install package
alias update='sudo pacman -Syu'                    # System update
alias search='pacman -Ss'                          # Search packages
alias remove='sudo pacman -Rs'                     # Remove package
alias autoremove='sudo pacman -Rns $(pacman -Qtdq)' # Remove orphans
alias aur='yay'                                    # AUR helper

# Development tools
alias python='python3'                             # Use Python 3
alias pip='pip3'                                   # Use pip3
alias venv='python -m venv'                        # Create virtual environment
alias activate='source venv/bin/activate'          # Activate venv
alias serve='python -m http.server'                # Simple HTTP server
alias json='python -m json.tool'                   # Format JSON

# Quick edits
alias zshrc='nvim ~/.zshrc'                        # Edit Zsh config
alias aliases='nvim ~/.zsh_aliases'                # Edit aliases
alias functions='nvim ~/.zsh_functions'            # Edit functions
alias exports='nvim ~/.zsh_exports'                # Edit exports

# Cleanup commands
alias clean='sudo pacman -Sc && yay -Sc'          # Clean package cache
alias logs='sudo journalctl --vacuum-size=50M'     # Clean logs
alias temp-clean='rm -rf /tmp/* ~/.cache/tmp/*'   # Clean temp files
```

### Custom Functions (`.zsh_functions`)
```bash
# Dionysus Custom Functions

# Project management
project() {
    if [[ -z "$1" ]]; then
        echo "Usage: project <name>"
        return 1
    fi
    
    local project_dir="$HOME/projects/$1"
    
    if [[ ! -d "$project_dir" ]]; then
        echo "Creating new project: $1"
        mkdir -p "$project_dir"
        cd "$project_dir"
        git init
        echo "# $1" > README.md
    else
        cd "$project_dir"
    fi
    
    # Open in preferred editor
    if command -v code >/dev/null; then
        code .
    elif command -v nvim >/dev/null; then
        nvim .
    fi
}

# Quick system information
sysinfo() {
    echo "=== Dionysus System Information ==="
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "CPU: $(lscpu | grep 'Model name' | awk -F: '{print $2}' | sed 's/^ *//')"
    echo "Memory: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "GPU: $(lspci | grep VGA | awk -F: '{print $3}' | sed 's/^ *//')"
    echo "Desktop: Hyprland (Dionysus)"
    echo "Shell: $SHELL"
    echo "Terminal: $TERM"
}

# Backup configuration
backup-config() {
    local backup_dir="$HOME/dionysus-backup-$(date +%Y%m%d-%H%M%S)"
    echo "Creating backup in $backup_dir"
    
    mkdir -p "$backup_dir"
    
    # Backup dotfiles
    cp -r ~/.config/hypr "$backup_dir/"
    cp -r ~/.config/waybar "$backup_dir/"
    cp -r ~/.config/eww "$backup_dir/"
    cp -r ~/.config/alacritty "$backup_dir/"
    cp -r ~/.config/rofi "$backup_dir/"
    cp -r ~/.config/cava "$backup_dir/"
    cp -r ~/.config/neofetch "$backup_dir/"
    
    # Backup shell configs
    cp ~/.zshrc "$backup_dir/"
    cp ~/.zsh_aliases "$backup_dir/" 2>/dev/null
    cp ~/.zsh_functions "$backup_dir/" 2>/dev/null
    cp ~/.zsh_exports "$backup_dir/" 2>/dev/null
    
    echo "Backup completed: $backup_dir"
}

# Restore configuration
restore-config() {
    if [[ -z "$1" || ! -d "$1" ]]; then
        echo "Usage: restore-config <backup-directory>"
        return 1
    fi
    
    echo "Restoring configuration from $1"
    
    # Create backup of current config
    backup-config
    
    # Restore from backup
    cp -r "$1"/* ~/.config/ 2>/dev/null
    cp "$1/.zshrc" ~/ 2>/dev/null
    cp "$1/.zsh_aliases" ~/ 2>/dev/null
    cp "$1/.zsh_functions" ~/ 2>/dev/null
    cp "$1/.zsh_exports" ~/ 2>/dev/null
    
    echo "Configuration restored. Please restart your session."
}

# Update all components
update-dionysus() {
    echo "=== Updating Dionysus Environment ==="
    
    # Update system packages
    echo "Updating system packages..."
    sudo pacman -Syu
    
    # Update AUR packages
    if command -v yay >/dev/null; then
        echo "Updating AUR packages..."
        yay -Sua
    fi
    
    # Update Oh My Zsh
    if [[ -d "$ZSH" ]]; then
        echo "Updating Oh My Zsh..."
        "$ZSH"/tools/upgrade.sh
    fi
    
    # Restart essential services
    echo "Restarting Waybar..."
    pkill waybar && waybar &
    
    echo "Restarting EWW..."
    eww kill && eww daemon &
    
    echo "Update completed!"
}

# Monitor system resources
monitor() {
    local mode="${1:-all}"
    
    case "$mode" in
        cpu)
            watch -n 1 "grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$3+\$4+\$5)} END {print usage \"%\"}'"
            ;;
        memory)
            watch -n 1 free -h
            ;;
        disk)
            watch -n 1 df -h
            ;;
        network)
            watch -n 1 "cat /proc/net/dev | grep -E '(wlp|eth|enp)'"
            ;;
        all|*)
            btop
            ;;
    esac
}

# Quick configuration edits
edit-config() {
    local component="$1"
    
    case "$component" in
        hypr|hyprland)
            nvim ~/.config/hypr/hyprland.conf
            ;;
        waybar)
            nvim ~/.config/waybar/config
            ;;
        eww)
            nvim ~/.config/eww/eww.yuck
            ;;
        alacritty)
            nvim ~/.config/alacritty/alacritty.toml
            ;;
        rofi)
            nvim ~/.config/rofi/config.rasi
            ;;
        cava)
            nvim ~/.config/cava/config
            ;;
        neofetch)
            nvim ~/.config/neofetch/config.conf
            ;;
        zsh)
            nvim ~/.zshrc
            ;;
        *)
            echo "Available components: hypr, waybar, eww, alacritty, rofi, cava, neofetch, zsh"
            ;;
    esac
}

# Workspace management
ws() {
    local workspace="$1"
    
    if [[ -z "$workspace" ]]; then
        hyprctl activeworkspace
    else
        hyprctl dispatch workspace "$workspace"
    fi
}

# Window management
win() {
    local action="$1"
    
    case "$action" in
        list)
            hyprctl clients
            ;;
        kill)
            hyprctl dispatch killactive
            ;;
        float)
            hyprctl dispatch togglefloating
            ;;
        fullscreen)
            hyprctl dispatch fullscreen
            ;;
        *)
            echo "Available actions: list, kill, float, fullscreen"
            ;;
    esac
}

# Development environment setup
dev-env() {
    local project_type="$1"
    
    case "$project_type" in
        python)
            python -m venv venv
            source venv/bin/activate
            pip install --upgrade pip
            echo "Python development environment ready"
            ;;
        node)
            npm init -y
            npm install --save-dev prettier eslint
            echo "Node.js development environment ready"
            ;;
        rust)
            cargo init
            echo "Rust development environment ready"
            ;;
        *)
            echo "Available project types: python, node, rust"
            ;;
    esac
}
```

### Environment Variables (`.zsh_exports`)
```bash
# Dionysus Environment Variables

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Wayland-specific
export WAYLAND_DISPLAY=wayland-1
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland

# Editor preferences
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# Development environment
export PYTHONPATH="$HOME/.local/lib/python3.11/site-packages:$PYTHONPATH"
export NODE_PATH="$HOME/.local/lib/node_modules"
export GOPATH="$HOME/go"
export CARGO_HOME="$HOME/.cargo"

# Path extensions
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# Application-specific
export BROWSER=firefox
export TERMINAL=alacritty
export FILEMANAGER=thunar

# Colors and theming
export LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34"
export GREP_COLOR="1;32"

# Performance optimizations
export HISTSIZE=50000
export SAVEHIST=50000
export HISTTIMEFORMAT="%d/%m/%y %T "

# Less pager configuration
export LESS="-R -S -M +Gg"
export LESSOPEN="| bat --color=always --style=plain %s"

# FZF configuration
export FZF_DEFAULT_OPTS="--color=16 --layout=reverse --border --height=40%"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude .git"

# GPG configuration
export GPG_TTY=$(tty)

# Locale settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Dionysus-specific
export DIONYSUS_CONFIG_DIR="$XDG_CONFIG_HOME"
export DIONYSUS_CACHE_DIR="$XDG_CACHE_HOME/dionysus"
export DIONYSUS_THEME="neon-radioactive"
```

## Installation and Setup

### Quick Installation
```bash
# Copy configuration files
cp .zshrc ~/.zshrc
cp .zsh_aliases ~/.zsh_aliases
cp .zsh_functions ~/.zsh_functions
cp .zsh_exports ~/.zsh_exports

# Set Zsh as default shell
chsh -s /usr/bin/zsh

# Install Oh My Zsh (if not already installed)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Reload configuration
source ~/.zshrc
```

### Dependencies
```bash
# Core Zsh
sudo pacman -S zsh

# Enhanced command-line tools
sudo pacman -S exa bat fd procs dust btop

# Development tools
sudo pacman -S git curl wget

# Optional enhancements
sudo pacman -S fzf ripgrep jq
```

## Customization

### Prompt Customization
The configuration uses Powerlevel10k for the prompt. Configure it by running:
```bash
p10k configure
```

### Adding Custom Aliases
Edit `~/.zsh_aliases` to add your own shortcuts:
```bash
# Personal aliases
alias myalias='your command here'
alias shortcut='long command with options'
```

### Creating Custom Functions
Add functions to `~/.zsh_functions`:
```bash
my_function() {
    # Your function code here
    echo "Custom function executed"
}
```

## Integration with Dionysus

### Automatic Desktop Integration
- **Neofetch animation** starts on new terminal sessions
- **EWW widgets** can be controlled via shell functions
- **Hyprland window management** through custom aliases
- **System monitoring** with themed output

### Workflow Optimization
- **Project management** functions for development
- **Configuration editing** shortcuts
- **System maintenance** automation
- **Resource monitoring** tools

## Troubleshooting

### Common Issues

**Zsh not starting:**
```bash
# Check shell setting
echo $SHELL

# Reset to Zsh
chsh -s /usr/bin/zsh
```

**Plugins not loading:**
```bash
# Check Oh My Zsh installation
ls ~/.oh-my-zsh/

# Reinstall plugins
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-*
# Then reinstall as shown in installation section
```

**Slow startup:**
```bash
# Profile startup time
zsh -xvs 2>&1 | head -20

# Disable heavy plugins temporarily
# Comment out plugins in .zshrc
```

**Colors not working:**
```bash
# Test color support
echo -e "\033[1;32mGreen\033[0m \033[1;36mCyan\033[0m"

# Check terminal color support
echo $TERM
```

---

<div align="center">

**Part of the Dionysus desktop environment**

*Enhanced shell experience with cyberpunk functionality*

</div>
