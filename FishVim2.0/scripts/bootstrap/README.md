# FishVim Bootstrap Scripts

These scripts set up a fresh machine so you can run FishVim quickly.

## Scripts

- `linux-ubuntu.sh` - Ubuntu/WSL setup via `apt`
- `macos.sh` - macOS setup via `brew`
- `windows.ps1` - Windows setup via `winget`

## Usage

Run from the repository root.

### Ubuntu / WSL

```bash
./scripts/bootstrap/linux-ubuntu.sh
nvim
```

### macOS

```bash
./scripts/bootstrap/macos.sh
nvim
```

### Windows (PowerShell)

```powershell
Set-ExecutionPolicy -Scope Process Bypass
./scripts/bootstrap/windows.ps1
nvim
```

## What The Scripts Do

- Install core dependencies (`git`, `ripgrep`, `fd`, `node`, `python`, etc.)
- Install platform-specific archive tooling (`unzip` on Linux/macOS, `7zip` on Windows)
- Copy `config/nvim` into your local Neovim config directory:
  - Linux/macOS: `~/.config/nvim`
  - Windows: `%LOCALAPPDATA%\nvim`

## Common Issues

### `stylua` failed in Mason

Cause:
- Missing `unzip` (Linux/macOS), or
- No network / DNS access to GitHub

Fix:
- Ensure `unzip` is installed and in PATH
- Verify GitHub reachability (`curl -I https://github.com`)
- Retry in Neovim:

```vim
:MasonInstall --force stylua
```

### Mason install loops or lockfile errors

Retry with force:

```vim
:MasonInstall --force <tool>
```

If still failing, restart Neovim and run:

```vim
:Mason
```

### Treesitter parser errors

Install/update parsers after network is available:

```vim
:TSInstall lua vim vimdoc query
:TSUpdate
```

## Verify Setup

After bootstrapping:

```vim
:Lazy
:Mason
:checkhealth
```

If all good, FishVim is ready.
