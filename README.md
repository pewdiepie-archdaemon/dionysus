# Dionysus

Dionysus is the first GitHub repository created by PewDiePie. It serves as a curated collection of dotfiles and utilities to personalize and enhance Linux desktop setups ("ricing").

##  What’s Inside

- `dotfiles/` — shell configurations, scripts, aliases, themes for tools like Waybar, Sway, or others.
- `assets/` — wallpapers, icons, shaders, CSS/SCSS styles, and static visual resources.

##  Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/pewdiepie-archdaemon/dionysus.git
cd dionysus
```

### 2. Review and Apply Configurations

```bash
cd dotfiles
# Explore available config files
ls
```

### 3. Apply Dotfiles

Example shell setup:

```bash
ln -sv "$(pwd)/.bashrc" ~/.bashrc
# Or for zsh:
ln -sv "$(pwd)/.zshrc" ~/.zshrc
source ~/.bashrc
```

Adjust for your shell and environment. Check for scripts or linked configs (e.g., Waybar, Sway).

##  Features

- Custom shell environments
- Artistic and functional assets
- Configuration for modern Linux window managers and desktop tools

##  Contributing

Suggestions, themes, or improved scripts are very welcome!

1. Fork the repo  
2. Create a branch `git checkout -b my-feature`  
3. Commit your changes `git commit -m "Add new theme"`  
4. Submit a pull request

###  Notes & Issues

Some users have already raised feedback about README clarity and project purpose. You can join the discussion via GitHub Issues.

##  Acknowledgements

Thanks to the community for helping PewDiePie establish his first GitHub project.

---

###  License

_No license specified. Consider adding one like MIT, GPL, etc._
