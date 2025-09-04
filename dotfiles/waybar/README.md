# Waybar Config

───────────────────────────────────────────────  
 °˖* ૮( • ᴗ ｡)っ🍸 shheersh - Dionysus vers. 1.0   
 ───────────────────────────────────────────────  
 
## Custom **Waybar** config.
![Waybar Demo](https://github.com/user-attachments/assets/e07b2650-40b2-41df-8efe-9e96f7d6871f)  

---

##  Features
- **Custom workspace** clickable modules (`workspace-1.sh` … `workspace-4.sh`)
- **Battery status** with JSON script + native fallback, dynamic icons, warnings
- **Volume control** via PipeWire (`wpctl`) with mute and scroll-to-change volume.
- **Microphone toggle** with instant mute/unmute
- **Brightness control** with slider, scroll actions, and toggle.
- **VPN integration** with NordVPN status.
- **Bluetooth module** with custom toggle script and tooltips
- **Network widget** with icons, bandwidth stats, and `nm-connection-editor` launcher
- **ASUS laptop profile** module, showing/toggling performance modes
- **Power menu** integration via Rofi  

![Waybar Demo 2](https://github.com/user-attachments/assets/6709a580-f138-41d3-9ae2-2c34256a4a20)  
![Waybar Demo 2.1](https://github.com/user-attachments/assets/d007f483-f18e-493f-b15d-dbb0ded056a2)
```
├── README.md
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
![Demo](https://github.com/user-attachments/assets/981a4cd0-c1ba-4d6a-8d9d-189c9ca3328c)

## Requirements
- `hyprland` (hyprctl for workspaces)
- `rofi` (for power menu)
- `wpctl` (PipeWire volume control)
- `playerctl`
- `brightnessctl`
- `nm-connection-editor`
- `nordvpn` (CLI client)
- `pactl` (PulseAudio/PipeWire control)
- `Nerd Font` for icons

## Usage
Requires a Nerd Font (for icons such as 󰤆, 󰖪, etc.)
Make sure scripts are executable:  
```chmod +x ~/.config/waybar/scripts/*.sh```  
```chmod +x ~/.config/waybar/scripts/workspaces/*.sh```
- `config` → main Waybar configuration
- `style.css` → custom styling
- `scripts/` → helper scripts for modules

