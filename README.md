<div align="center">

<img width="2322" height="972" alt="FishVim 2.0" src="https://github.com/user-attachments/assets/491a21e5-c576-48ee-a054-efc62a8e03b5" />

<p><strong>The Hacker's Vim Choice</strong></p>

<p>
<img src="https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white" />
<img src="https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" />
<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" />
<img src="https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white" />
<img src="https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white" />
</p>

</div>

> A full-featured, cyberpunk-themed Neovim configuration built for hackers, engineers, and terminal maximalists. 80+ plugins, zero bloat, zero compromises.

---

## What's Inside

| Category | Stack |
|---|---|
| **Plugin Manager** | `lazy.nvim` (lazy-loading, fast startup) |
| **Completion** | `blink.cmp` (Rust fuzzy, 6× faster than nvim-cmp) |
| **LSP** | `mason` + `nvim-lspconfig` + 16 language servers |
| **Syntax** | `nvim-treesitter` + textobjects + 22 parsers |
| **Formatting** | `conform.nvim` (format-on-save) |
| **Linting** | `nvim-lint` (async, per-filetype) |
| **Git** | `gitsigns` + `lazygit` + `diffview` + `neogit` |
| **Debugging** | `nvim-dap` + `nvim-dap-ui` (Python, Rust/C, JS/TS) |
| **Testing** | `neotest` (Python, Go, Vitest) |
| **File Nav** | `telescope` + `harpoon2` + `oil.nvim` + `nvim-tree` |
| **Motions** | `flash.nvim` (s/S jump) |
| **Code Folding** | `nvim-ufo` (LSP/Treesitter, peek folds with K) |
| **AI** | `codecompanion.nvim` (Claude Sonnet, GPT, Ollama) |
| **UI** | `noice` + `snacks.nvim` + `bufferline` + `lualine` |
| **Theme** | `tokyonight` cyberpunk override (jet-black, neon green) |

---

## First-Time Setup (Run This First)

Clone the repo, run one bootstrap script for your OS, then open Neovim.

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

What the bootstrap scripts install:
- System tools: `git`, `ripgrep`, `fd`, `node`, `python3`, `unzip`, `lazygit`, `go`
- Fonts: a Nerd Font (required for icons and powerline glyphs)
- The config into `~/.config/nvim`

---

## After First Launch

```vim
:Lazy          " Install/update plugins
:Mason         " Verify LSP servers and tools
:checkhealth   " Diagnose any issues
```

On the first launch, lazy.nvim downloads all plugins and Mason installs all LSP servers and formatters automatically.

---

## AI Setup (Optional)

FishVim includes `codecompanion.nvim` for AI-powered coding assistance (Claude Sonnet by default).

```bash
# Add to your shell profile (~/.bashrc, ~/.zshrc, or ~/.config/fish/config.fish)
export ANTHROPIC_API_KEY="sk-ant-..."
```

Then use `<leader>ai` to open the AI chat, `<leader>aa` for context-aware actions, or `<leader>ac` for inline edits.

Supports: **Claude** (Anthropic), **GPT-4** (OpenAI), **Gemini**, **Ollama** (local).

---

## FishVim Identity

- Shark + FishVim startup dashboard with Lazy plugin stats
- Cyberpunk colorscheme: jet-black background, neon green, electric blue, magenta
- Leader key is `<Space>` — press it to see available groups via which-key
- All keymaps follow logical namespace groups

---

## Core Shortcuts

| Key | Action |
|---|---|
| `jk` | Exit insert mode |
| `<C-s>` | Save file (any mode) |
| `<Tab>` / `<S-Tab>` | Next / Prev buffer |
| `s` / `S` | Flash jump / Flash treesitter jump |
| `-` | Oil: open parent directory |
| `K` | Peek fold (or hover docs if not on fold) |
| `zR` / `zM` | Open all / Close all folds |
| `zr` / `zm` | Fold less / Fold more |
| `]]` / `[[` | Next / Prev word occurrence (snacks) |
| `]f` / `[f` | Next / Prev function |
| `]c` / `[c` | Next / Prev class |
| `cx<motion>` | Substitute motion with register |
| `cxx` | Substitute entire line |
| `cX` | Substitute to end of line |
| `gc` | Toggle comment |
| `ys` / `cs` / `ds` | Add / Change / Delete surroundings |
| `<C-h/j/k/l>` | Navigate windows |

---

## Leader `<Space>` Command Guide

<details>
<summary><b>📁 Files / Search — <code>&lt;leader&gt;f</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep |
| `<leader>fc` | Search word under cursor |
| `<leader>fb` | Buffer list |
| `<leader>fh` | Help tags |
| `<leader>fp` | Projects picker |
| `<leader>fk` | Keymaps picker |
| `<leader><space>` | Find files (quick) |

</details>

<details>
<summary><b>🔀 Git — <code>&lt;leader&gt;g</code>, <code>&lt;leader&gt;h</code>, <code>&lt;leader&gt;x</code></b></summary>

<br>

**LazyGit / Neogit / Diffview**

| Key | Action |
|---|---|
| `<leader>gg` | Open LazyGit |
| `<leader>gn` | Neogit (Magit-style interactive git) |
| `<leader>gd` | Diffview open (all changed files) |
| `<leader>gh` | Current file git history |
| `<leader>gH` | Branch git history |
| `<leader>gx` | Close Diffview |
| `<leader>gB` | Open current line in browser (snacks gitbrowse) |
| `<leader>gz` | Zen / focus mode (snacks) |

**Git Hunks (gitsigns)**

| Key | Action |
|---|---|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hB` | Toggle line blame |
| `<leader>hd` | Diff this |
| `<leader>hD` | Diff this ~ |
| `]h` / `[h` | Next / Prev hunk |
| `ih` | Select hunk (text object) |

**Trouble Lists**

| Key | Action |
|---|---|
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xt` | TODO list |

</details>

<details>
<summary><b>🔧 LSP / Diagnostics — <code>&lt;leader&gt;l</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>la` | Code actions |
| `<leader>lr` | Rename symbol |
| `<leader>ld` | Line diagnostics float |
| `<leader>lD` | Buffer diagnostics (Telescope) |
| `<leader>ls` | Restart LSP |
| `<leader>ll` | Lint current buffer |
| `<leader>li` | LSP info |
| `<leader>lh` | Toggle inlay hints |
| `gd` | Go to definition |
| `gR` | LSP references |
| `gD` | LSP declaration |
| `gi` | LSP implementations |
| `gt` | LSP type definition |
| `K` | Hover docs / Peek fold |
| `]d` / `[d` | Next / Prev diagnostic |

**Language Servers Included:**
`lua_ls`, `ts_ls`, `pyright`, `gopls`, `rust_analyzer`, `clangd`, `cssls`, `html`, `jsonls`, `yamlls`, `bashls`, `svelte`, `graphql`, `emmet_ls`, `taplo`, `marksman`, `dockerls`

</details>

<details>
<summary><b>🤖 AI Assistant — <code>&lt;leader&gt;a</code></b></summary>

<br>

> Requires `ANTHROPIC_API_KEY` set in your environment (Claude Sonnet default)

| Key | Action |
|---|---|
| `<leader>ai` | Toggle AI Chat panel |
| `<leader>aa` | AI Actions menu (context-aware) |
| `<leader>ac` | AI Inline assistant |
| `<leader>ae` | Add visual selection to chat |

Supports: Claude, GPT-4, Gemini, Ollama (local). Change adapter in `plugins/codecompanion.lua`.

</details>

<details>
<summary><b>🐛 Debug — <code>&lt;leader&gt;d</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>dc` | Continue |
| `<leader>dt` | Terminate |
| `<leader>db` | Toggle breakpoint |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dr` | Open REPL |
| `<leader>du` | Toggle debug UI |

**Supported:** Python (debugpy), Rust/C/C++ (codelldb), JavaScript/TypeScript (js-debug-adapter)

</details>

<details>
<summary><b>🧪 Tests / TODO — <code>&lt;leader&gt;t</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>td` | Debug nearest test |
| `<leader>ts` | Toggle test summary |
| `<leader>to` | Test output panel |
| `<leader>tS` | Stop tests |
| `<leader>tt` | TODO Telescope picker |
| `]t` / `[t` | Next / Prev TODO |

**Supported:** Python (pytest/unittest), Go, Vitest (JS/TS)

</details>

<details>
<summary><b>📄 Buffers — <code>&lt;leader&gt;b</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>bp` | Pick buffer |
| `<leader>bc` | Pick and close buffer |
| `<leader>bd` | Close current buffer |
| `<leader>bl` | Move buffer right |
| `<leader>bh` | Move buffer left |
| `<leader>bs` | Sort by extension |
| `<Tab>` / `<S-Tab>` | Next / Prev buffer |

</details>

<details>
<summary><b>🪟 Windows / Sessions — <code>&lt;leader&gt;w</code>, <code>&lt;leader&gt;s</code></b></summary>

<br>

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
| `<leader>wp` | Prev tab |
| `<leader>wf` | Current buffer in new tab |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>se` | Equalize splits |
| `<leader>sx` | Close split |
| `<leader>sm` | Toggle split maximizer |

</details>

<details>
<summary><b>🗂️ Explorer — <code>&lt;leader&gt;e</code>, <code>-</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>ee` | Toggle nvim-tree sidebar |
| `<leader>ef` | Reveal current file in tree |
| `<leader>ec` | Collapse tree |
| `<leader>er` | Refresh tree |
| `<leader>eo` | Oil: open parent dir (buffer mode) |
| `<leader>eO` | Oil: float window |
| `-` | Oil: open parent directory |

**Oil.nvim tips:** Navigate to a directory with `-`, then edit filenames/paths as text. Save (`:w`) to commit file operations. `g.` toggles hidden files.

</details>

<details>
<summary><b>🖥️ UI / Utility — <code>&lt;leader&gt;u</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>ut` | Toggle floating terminal |
| `<leader>ug` | LazyGit in terminal |
| `<leader>uw` | Toggle word wrap |
| `<leader>us` | Toggle spellcheck |
| `<leader>mp` | Format file / range (conform) |
| `<leader>nh` | Clear search highlight |
| `<leader>+` | Increment number |
| `<leader>-` | Decrement number |
| `<leader>qq` | Quit all |
| `<leader>N` | Notification history |

</details>

<details>
<summary><b>🎯 Harpoon — <code>&lt;leader&gt;h</code></b></summary>

<br>

| Key | Action |
|---|---|
| `<leader>ha` | Add file to harpoon |
| `<leader>hh` | Harpoon quick menu |
| `<leader>h1` | Jump to file 1 |
| `<leader>h2` | Jump to file 2 |
| `<leader>h3` | Jump to file 3 |
| `<leader>h4` | Jump to file 4 |

</details>

<details>
<summary><b>📦 Treesitter Text Objects</b></summary>

<br>

Works with any operator (`v`, `d`, `c`, `y`) like built-in text objects.

| Key | Object |
|---|---|
| `af` / `if` | Around / Inside function |
| `ac` / `ic` | Around / Inside class |
| `aa` / `ia` | Around / Inside argument |
| `al` / `il` | Around / Inside loop |
| `ab` / `ib` | Around / Inside block |
| `]f` / `[f` | Jump to next / prev function |
| `]c` / `[c` | Jump to next / prev class |
| `<leader>sa` | Swap argument with next |
| `<leader>sA` | Swap argument with prev |

Also powered by `mini.ai`: `va)`, `vi"`, `va,`, `vi,`, and many more enhanced text objects.

</details>

---

## Plugin List (80+ plugins)

<details>
<summary><b>Full plugin inventory</b></summary>

<br>

| Category | Plugin | Purpose |
|---|---|---|
| **Manager** | `folke/lazy.nvim` | Plugin manager with lazy-loading |
| **UI Core** | `folke/snacks.nvim` | Indent, input, scroll, words, statuscolumn, zen, gitbrowse, bigfile, animate |
| **UI** | `folke/noice.nvim` | Floating cmdline, LSP progress, message routing |
| **UI** | `rcarriga/nvim-notify` | Notification popups |
| **UI** | `stevearc/dressing.nvim` | (disabled, replaced by snacks.input) |
| **Colorscheme** | `folke/tokyonight.nvim` | Cyberpunk-overridden dark theme |
| **Dashboard** | `goolord/alpha-nvim` | Shark + FishVim startup screen |
| **Statusline** | `nvim-lualine/lualine.nvim` | Custom FishVim neon status bar |
| **Bufferline** | `akinsho/bufferline.nvim` | Tab bar with slant separators |
| **Icons** | `echasnovski/mini.icons` | Fast icon provider (mocks nvim-web-devicons) |
| **Icons** | `nvim-tree/nvim-web-devicons` | Fallback icon library |
| **Which-key** | `folke/which-key.nvim` | Keymap hint popup (200ms delay) |
| **Explorer** | `nvim-tree/nvim-tree.lua` | Sidebar file tree |
| **Explorer** | `stevearc/oil.nvim` | Edit filesystem as a buffer (`-` key) |
| **Fuzzy** | `nvim-telescope/telescope.nvim` | Fuzzy finder + extensions |
| **Motions** | `folke/flash.nvim` | Jump with `s`/`S`, treesitter labels |
| **Harpoon** | `ThePrimeagen/harpoon` | Quick file bookmarks (1-4 slots) |
| **Tmux** | `christoomey/vim-tmux-navigator` | Ctrl-hjkl across tmux panes |
| **LSP** | `neovim/nvim-lspconfig` | LSP client configuration |
| **LSP** | `williamboman/mason.nvim` | Tool installer (LSP, DAP, linters, formatters) |
| **LSP** | `williamboman/mason-lspconfig.nvim` | Mason + lspconfig bridge |
| **LSP** | `WhoIsSethDaniel/mason-tool-installer.nvim` | Auto-install formatters/linters |
| **LSP** | `folke/lazydev.nvim` | Neovim Lua API completion (replaces neodev) |
| **LSP** | `antosha417/nvim-lsp-file-operations` | LSP file rename/move |
| **Completion** | `saghen/blink.cmp` | Completion engine (Rust, replaces nvim-cmp) |
| **Snippets** | `rafamadriz/friendly-snippets` | VSCode snippet collection |
| **Formatting** | `stevearc/conform.nvim` | Format-on-save (1500ms timeout) |
| **Linting** | `mfussenegger/nvim-lint` | Async per-filetype linting |
| **Treesitter** | `nvim-treesitter/nvim-treesitter` | Syntax, highlight, indent, 22 parsers |
| **Treesitter** | `nvim-treesitter/nvim-treesitter-textobjects` | Function/class/arg text objects |
| **Treesitter** | `windwp/nvim-ts-autotag` | Auto-close HTML/JSX tags |
| **Folding** | `kevinhwang91/nvim-ufo` | LSP/Treesitter code folding with peek |
| **Editing** | `windwp/nvim-autopairs` | Auto-close brackets |
| **Editing** | `numToStr/Comment.nvim` | Toggle comments (`gc`/`gb`) |
| **Editing** | `JoosepAlviste/nvim-ts-context-commentstring` | JSX/TSX comment context |
| **Editing** | `kylechui/nvim-surround` | `ys`/`cs`/`ds` surround operations |
| **Editing** | `gbprod/substitute.nvim` | `cx` paste-and-replace motions |
| **Editing** | `echasnovski/mini.ai` | Enhanced `a`/`i` text objects |
| **Git** | `lewis6991/gitsigns.nvim` | Hunk signs, inline blame, stage |
| **Git** | `kdheepak/lazygit.nvim` | LazyGit TUI integration |
| **Git** | `sindrets/diffview.nvim` | Full diff view, file history |
| **Git** | `NeogitOrg/neogit` | Magit-style interactive git UI |
| **Diagnostics** | `folke/trouble.nvim` | Diagnostics/qflist panel |
| **Diagnostics** | `folke/todo-comments.nvim` | TODO/FIXME highlighting |
| **DAP** | `mfussenegger/nvim-dap` | Debug Adapter Protocol |
| **DAP** | `rcarriga/nvim-dap-ui` | Debug UI |
| **DAP** | `jay-babu/mason-nvim-dap.nvim` | Mason DAP installer |
| **DAP** | `theHamsta/nvim-dap-virtual-text` | Inline variable values |
| **DAP** | `mfussenegger/nvim-dap-python` | Python debug adapter |
| **Testing** | `nvim-neotest/neotest` | Test runner framework |
| **Testing** | `nvim-neotest/neotest-python` | Python tests |
| **Testing** | `nvim-neotest/neotest-go` | Go tests |
| **Testing** | `marilari88/neotest-vitest` | Vitest (JS/TS) |
| **Sessions** | `rmagatti/auto-session` | Session save/restore per cwd |
| **Windows** | `szw/vim-maximizer` | Toggle split maximization |
| **Terminal** | `akinsho/toggleterm.nvim` | Floating terminal (`<C-\>`) |
| **AI** | `olimorris/codecompanion.nvim` | Claude/GPT/Ollama AI assistant |

</details>

---

## Troubleshooting

| Command | Purpose |
|---|---|
| `:Lazy` | Plugin manager UI |
| `:Mason` | Tool manager UI |
| `:checkhealth` | Environment diagnostics |
| `:messages` | Recent warnings/errors |
| `:LspInfo` | Active LSP state |
| `:Noice` | Message/notification history |

If something breaks after upgrades:

```vim
:Lazy sync
:MasonUpdate
:checkhealth
```

**Common issues:**
- Icons not rendering → install a [Nerd Font](https://www.nerdfonts.com/) and set it in your terminal
- LSP not starting → run `:LspInfo` and `:Mason` to check server status
- blink.cmp not completing → run `:checkhealth blink.cmp`
- AI not working → verify `ANTHROPIC_API_KEY` is set in your environment

---

## Notes

- First install requires internet access
- Some tool downloads fail in offline/blocked DNS environments
- If `stylua` fails in Mason, ensure `unzip` is installed (`apt install unzip`)
- Go tools (`goimports`, `golangci-lint`) require `go` installed on PATH
- Python tools (`black`, `ruff`, `debugpy`) require `python3` and `pip`

---

## Author

**Nicholas Fisher**

[![GitHub](https://img.shields.io/badge/GitHub-NeptuneCipher42-181717?style=flat&logo=github&logoColor=white)](https://github.com/NeptuneCipher42)
