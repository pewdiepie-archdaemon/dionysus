# CAVA config

───────────────────────────────────────────────  
 °˖* ૮( • ᴗ ｡)っ🍸 shheersh - Dionysus vers. 1.0   
 ───────────────────────────────────────────────  

## Custom **CAVA** config
Outputs raw ASCII data for easy integration.
![EWW Demo Png](https://github.com/user-attachments/assets/2603a6bb-a50f-4129-be30-90361cf4c8c7)
---

##  Features
Raw ASCII output → written to /tmp/cava.raw so it can be piped into:

    - EWW widgets
    - Waybar modules
    - custom ASCII scripts

## Usage
Run with `cava -p ~/.config/cava/config`
CAVA writes raw ASCII bars to `/tmp/cava.raw`

![Cava Demo Gif](https://github.com/user-attachments/assets/658adf6c-a9c7-4f45-ac65-9c7373a444f7)

## Pipe into your visualizer
Can pair with: [audio_visualizer.py](../eww/scripts/audio/audio_visualizer.py) for Ascii style visualizer.

```
python3 dotfiles/eww/scripts/audio/audio_visualizer.py
```
or in terminal:

```
watch -n0.1 cat /tmp/visualizer.txt
```


