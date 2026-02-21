# FishVim 2.0 - Hacker's Vim Choice
<img width="2322" height="972" alt="image" src="https://github.com/user-attachments/assets/491a21e5-c576-48ee-a054-efc62a8e03b5" />
By Nicholas Fisher

Quick bootstrap docs: [`scripts/bootstrap/README.md`](scripts/bootstrap/README.md)

## First-Time Setup (Run This First)

Clone the repo, run one bootstrap script for your OS, then open Neovim.

### Linux / WSL (Ubuntu)

```bash
git clone https://github.com/NeptuneCipher42/FishVim2.0.git
cd FishVim1.0
./scripts/bootstrap/linux-ubuntu.sh
mv ~/FishVim2.0/config ~/.config
nvim
```

### macOS

```bash
git clone https://github.com/NeptuneCipher42/FishVim2.0.git
cd FishVim1.0
./scripts/bootstrap/macos.sh
mv ~/FishVim2.0/config ~/.config
nvim
```

### Windows (PowerShell)

```powershell
Set-ExecutionPolicy -Scope Process Bypass
git clone https://github.com/NeptuneCipher42/FishVim2.0.git
cd FishVim1.0
./scripts/bootstrap/windows.ps1
mv ~/FishVim2.0/config ~/.config
nvim
```

What these scripts do:
- Install system dependencies (`git`, `ripgrep`, `fd`, `node`, `python`, `unzip`, etc.)
- Copy FishVim config into the Neovim config directory (`~/.config/nvim` or `%LOCALAPPDATA%\nvim`)
- Leave you ready to launch `nvim`

## After First Launch

- Run `:Lazy` and let plugins install/update.
- Run `:Mason` to check language servers and tools.
- If anything is missing, run:
  - `:Lazy sync`
  - `:MasonInstall <tool-name>`

## FishVim Identity

- Shark + FishVim startup dashboard
- Leader key is `<Space>`
- Press `<Space>` to see available command groups via which-key

## Core Shortcuts

| Key | Action |
|---|---|
| `jk` | Exit insert mode |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `]t` / `[t` | Next/Previous TODO |
| `]h` / `[h` | Next/Previous git hunk |

## Leader `<Space>` Command Guide

### Files / Search (`<leader>f`)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep |
| `<leader>fc` | Search word under cursor |
| `<leader>fb` | Buffers picker |
| `<leader>fh` | Help tags |
| `<leader>fp` | Projects picker |
| `<leader>fk` | Keymaps picker |

### Git / Trouble (`<leader>g`, `<leader>h`, `<leader>x`)

| Key | Action |
|---|---|
| `<leader>gg` | Open LazyGit |
| `<leader>lg` | Open LazyGit (legacy alias) |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hB` | Toggle line blame |
| `<leader>hd` | Diff file |
| `<leader>hD` | Diff file vs `~` |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xt` | TODO list |

### LSP / Diagnostics (`<leader>l`)

| Key | Action |
|---|---|
| `<leader>la` | Code actions |
| `<leader>lr` | Rename symbol |
| `<leader>ld` | Line diagnostics |
| `<leader>lD` | Buffer diagnostics |
| `<leader>ls` | Restart LSP |
| `<leader>ll` | Lint current buffer |

### Debug (`<leader>d`)

| Key | Action |
|---|---|
| `<leader>dc` | Continue debug |
| `<leader>dt` | Terminate debug |
| `<leader>db` | Toggle breakpoint |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dr` | Open debug REPL |
| `<leader>du` | Toggle debug UI |

### Tests / TODO (`<leader>t`)

| Key | Action |
|---|---|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>td` | Debug nearest test |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Test output |
| `<leader>tS` | Stop tests |
| `<leader>tt` | TODO Telescope |

### Buffers (`<leader>b`)

| Key | Action |
|---|---|
| `<leader>bp` | Pick buffer |
| `<leader>bc` | Pick and close buffer |
| `<leader>bd` | Close current buffer |
| `<leader>bl` | Move buffer right |
| `<leader>bh` | Move buffer left |
| `<leader>bs` | Sort buffers by extension |

### Windows / Sessions (`<leader>w`, `<leader>s`)

| Key | Action |
|---|---|
| `<leader>ww` | Save file |
| `<leader>wr` | Restore session |
| `<leader>wS` | Save session |
| `<leader>wa` | Window left |
| `<leader>ws` | Window down |
| `<leader>wd` | Window right |
| `<leader>wq` | Window up |
| `<leader>wo` | New tab |
| `<leader>wx` | Close tab |
| `<leader>wn` | Next tab |
| `<leader>wp` | Previous tab |
| `<leader>wf` | Current buffer in tab |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>sm` | Toggle split maximizer |

Legacy movement aliases:
- `<leader>a`, `<leader>s`, `<leader>d`, `<leader>q`

### Explorer (`<leader>e`)

| Key | Action |
|---|---|
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Explorer current file |
| `<leader>ec` | Collapse explorer |
| `<leader>er` | Refresh explorer |

### UI / Utility

| Key | Action |
|---|---|
| `<leader>u` | Toggle relative number |
| `<leader>ut` | Toggle terminal |
| `<leader>ug` | LazyGit in terminal |
| `<leader>mp` | Format file/range |
| `<leader>nh` | Clear search highlight |
| `<leader>+` | Increment number |
| `<leader>-` | Decrement number |
| `<leader>qq` | Quit all |

### Harpoon

| Key | Action |
|---|---|
| `<leader>ha` | Add file |
| `<leader>hh` | Quick menu |
| `<leader>h1` | File 1 |
| `<leader>h2` | File 2 |
| `<leader>h3` | File 3 |
| `<leader>h4` | File 4 |

## Troubleshooting

| Command | Purpose |
|---|---|
| `:Lazy` | Plugin manager UI |
| `:Mason` | Tool manager UI |
| `:checkhealth` | Environment diagnostics |
| `:messages` | Recent warnings/errors |
| `:LspInfo` | Active LSP state |

If something breaks after upgrades:

```vim
:Lazy sync
:Mason
:checkhealth
```

## Notes

- First install requires working internet access.
- Some tool downloads fail in offline/blocked DNS environments.
- If `stylua` fails in Mason, ensure `unzip` is installed on your system.
