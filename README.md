<div align="center">

<img width="2322" height="972" alt="FishVim 2.0" src="https://github.com/user-attachments/assets/491a21e5-c576-48ee-a054-efc62a8e03b5" />

### The Hacker's Vim Choice

![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)

</div>

---

## 📋 Table of Contents

- [First-Time Setup](#first-time-setup)
  - [Linux / WSL](#linux--wsl-ubuntu)
  - [macOS](#macos)
- [After First Launch](#after-first-launch)
- [FishVim Identity](#fishvim-identity)
- [Core Shortcuts](#core-shortcuts)
- [Leader Command Guide](#leader-space-command-guide)
- [Troubleshooting](#troubleshooting)

---

## First-Time Setup

Clone the repo, run one bootstrap script for your OS, then open Neovim. Full bootstrap docs: [`scripts/bootstrap/README.md`](scripts/bootstrap/README.md)

### Linux / WSL (Ubuntu)

```bash
git clone https://github.com/NeptuneCipher42/FishVim2.0.git
cd FishVim2.0
unzip config.zip
./scripts/bootstrap/linux-ubuntu.sh
mv ~/FishVim2.0/config ~/.config
nvim
```

### macOS

```bash
git clone https://github.com/NeptuneCipher42/FishVim2.0.git
cd FishVim2.0
unzip config.zip
./scripts/bootstrap/macos.sh
mv ~/FishVim2.0/config ~/.config
nvim
```

**What the bootstrap scripts do:**
- Install system dependencies (`git`, `ripgrep`, `fd`, `node`, `python`, `unzip`, etc.)
- Copy FishVim config into the Neovim config directory (`~/.config/nvim`)
- Leave you ready to launch `nvim`

---

## After First Launch

- Run `:Lazy` and let plugins install/upda
