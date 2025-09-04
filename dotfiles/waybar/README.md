# waybar config

───────────────────────────────────────────────  
 °˖* ૮( • ᴗ ｡)っ🍸 shheersh - dionysus vers. 1.0   
 ───────────────────────────────────────────────  
 
## custom **waybar** config.
![waybar demo](https://github.com/user-attachments/assets/e07b2650-40b2-41df-8efe-9e96f7d6871f)  
---

##  features
- **custom workspace** clickable modules (`workspace-1.sh` … `workspace-4.sh`)
- **battery status** with json script + native fallback, dynamic icons, warnings
- **volume control** via pipewire (`wpctl`) with mute and scroll-to-change volume.
- **microphone toggle** with instant mute/unmute
- **brightness control** with slider, scroll actions, and toggle.
- **vpn integration** with nordvpn status.
- **bluetooth module** with custom toggle script and tooltips
- **network widget** with icons, bandwidth stats, and `nm-connection-editor` launcher
- **asus laptop profile** module, showing/toggling performance modes
- **power menu** integration via rofi  

![waybar demo 2](https://github.com/user-attachments/assets/6709a580-f138-41d3-9ae2-2c34256a4a20)  
![waybar demo 2.1](https://github.com/user-attachments/assets/d007f483-f18e-493f-b15d-dbb0ded056a2)
```
├── readme.md
├── config
├── demo.png
├── scripts
│   ├── asus-profile.sh
│   ├── battery.sh
│   ├── bluetooth-toggle.sh
│   ├── brightness-toggle.sh
│   ├── brightness.sh
│   ├── mic.sh
│   ├── nordvpn-status.sh
│   ├── nordvpn-toggle.sh
│   ├── powermenu.sh
│   ├── volume.sh
│   └── workspaces
│       ├── workspace-1.sh
│       ├── workspace-2.sh
│       ├── workspace-3.sh
│       └── workspace-4.sh
└── style.css
```
![demo](https://github.com/user-attachments/assets/981a4cd0-c1ba-4d6a-8d9d-189c9ca3328c)

## requirements
- `hyprland` (hyprctl for workspaces)
- `rofi` (for power menu)
- `wpctl` (pipewire volume control)
- `playerctl`
- `brightnessctl`
- `nm-connection-editor`
- `nordvpn` (cli client)
- `pactl` (pulseaudio/pipewire control)
- `nerd font` for icons

## usage
requires a nerd font (for icons such as 󰤆, 󰖪, etc.)
make sure scripts are executable:  
```chmod +x ~/.config/waybar/scripts/*.sh```  
```chmod +x ~/.config/waybar/scripts/workspaces/*.sh```
- `config` → main waybar configuration
- `style.css` → custom styling
- `scripts/` → helper scripts for modules

