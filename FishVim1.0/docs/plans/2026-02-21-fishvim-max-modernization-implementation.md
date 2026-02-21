# FishVim Max Modernization Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Upgrade FishVim1.0 into a maximum-capability, production-ready Neovim distribution while preserving and improving the shark-branded FishVim startup experience.

**Architecture:** Restore the tracked baseline config first, then refactor in-place into coherent modules with namespaced leader mappings and lazy-loaded capabilities. Keep startup identity in the dashboard layer, and synchronize docs by generating a complete README command catalog from final keymaps.

**Tech Stack:** Neovim Lua config, lazy.nvim, which-key, alpha/dashboard UI, Mason/LSP, nvim-dap, telescope, gitsigns, trouble, nvim-test integrations.

---

### Task 1: Restore Baseline and Capture Current State

**Files:**
- Modify: `config/**` (restore tracked files)
- Create: `docs/plans/2026-02-21-fishvim-audit.md`

**Step 1: Write the failing test**

```bash
git -C /home/fishern2000/FishVim1.0 status --short | rg '^ D config/'
```

Expected: finds deleted tracked files (baseline is not usable).

**Step 2: Run test to verify it fails**

Run: same command above.  
Expected: multiple matches.

**Step 3: Write minimal implementation**

```bash
git -C /home/fishern2000/FishVim1.0 restore --source=HEAD --worktree -- config
```

**Step 4: Run test to verify it passes**

Run:

```bash
git -C /home/fishern2000/FishVim1.0 status --short | rg '^ D config/' || true
```

Expected: no matches.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add config docs/plans/2026-02-21-fishvim-audit.md
git -C /home/fishern2000/FishVim1.0 commit -m "chore: restore FishVim baseline config for modernization"
```

### Task 2: Establish Core Module Hygiene and Mapping Namespace

**Files:**
- Modify: `config/nvim/lua/fisher/core/options.lua`
- Modify: `config/nvim/lua/fisher/core/keymaps.lua`
- Modify: `config/nvim/lua/fisher/core/init.lua`
- Test: headless Neovim startup command

**Step 1: Write the failing test**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua "+lua print(vim.g.mapleader)" +qa
```

Expected: output not aligned with final namespace expectations or errors due missing modules.

**Step 2: Run test to verify it fails**

Run command above and capture output.

**Step 3: Write minimal implementation**

```lua
-- config/nvim/lua/fisher/core/keymaps.lua
vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Namespace roots for which-key discovery and consistency
map("n", "<leader>f", "<cmd>Telescope find_files<CR>", vim.tbl_extend("force", opts, { desc = "Files" }))
map("n", "<leader>g", "<cmd>LazyGit<CR>", vim.tbl_extend("force", opts, { desc = "Git" }))
map("n", "<leader>l", "<cmd>Trouble diagnostics toggle<CR>", vim.tbl_extend("force", opts, { desc = "LSP/Diagnostics" }))
map("n", "<leader>d", "<cmd>lua require('dap').continue()<CR>", vim.tbl_extend("force", opts, { desc = "Debug" }))
map("n", "<leader>t", "<cmd>TodoTelescope<CR>", vim.tbl_extend("force", opts, { desc = "Tasks/Tests/Todo" }))
map("n", "<leader>b", "<cmd>BufferLinePick<CR>", vim.tbl_extend("force", opts, { desc = "Buffers" }))
map("n", "<leader>w", "<cmd>SessionSave<CR>", vim.tbl_extend("force", opts, { desc = "Windows/Workspace" }))
map("n", "<leader>u", "<cmd>set invrelativenumber<CR>", vim.tbl_extend("force", opts, { desc = "UI toggles" }))
```

**Step 4: Run test to verify it passes**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua +qa
```

Expected: clean exit with no startup errors.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add config/nvim/lua/fisher/core
git -C /home/fishern2000/FishVim1.0 commit -m "refactor: normalize FishVim core options and keymap namespaces"
```

### Task 3: Upgrade Dashboard (Shark + FishVim Identity)

**Files:**
- Modify: `config/nvim/lua/fisher/plugins/alpha.lua`
- Modify: `config/nvim/lua/fisher/plugins/colorscheme.lua`
- Test: headless render sanity command

**Step 1: Write the failing test**

```bash
rg -n "H A C K E R ' S  V I M  C H O I C E|FishVim|shark" /home/fishern2000/FishVim1.0/config/nvim/lua/fisher/plugins/alpha.lua
```

Expected: current banner lacks improved sections/buttons/metadata.

**Step 2: Run test to verify it fails**

Run command above and confirm missing improved dashboard constructs.

**Step 3: Write minimal implementation**

```lua
-- alpha.lua (core idea)
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  "<shark ascii trimmed>",
  "F I S H V I M",
  "HACKER'S VIM CHOICE"
}
dashboard.section.buttons.val = {
  dashboard.button("f", "Find File", ":Telescope find_files<CR>"),
  dashboard.button("r", "Recent", ":Telescope oldfiles<CR>"),
  dashboard.button("p", "Projects", ":Telescope projects<CR>"),
  dashboard.button("s", "Restore Session", ":SessionRestore<CR>"),
  dashboard.button("m", "Mason", ":Mason<CR>"),
  dashboard.button("l", "Lazy", ":Lazy<CR>"),
}
```

**Step 4: Run test to verify it passes**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua +qa
```

Expected: no alpha-related errors.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add config/nvim/lua/fisher/plugins/alpha.lua config/nvim/lua/fisher/plugins/colorscheme.lua
git -C /home/fishern2000/FishVim1.0 commit -m "feat: enhance FishVim shark dashboard and startup UX"
```

### Task 4: Max Capability Language Toolchain (LSP/Format/Lint)

**Files:**
- Modify: `config/nvim/lua/fisher/plugins/lsp/mason.lua`
- Modify: `config/nvim/lua/fisher/plugins/lsp/config.lsplua`
- Modify: `config/nvim/lua/fisher/plugins/formatting.lua`
- Modify: `config/nvim/lua/fisher/plugins/linting.lua`

**Step 1: Write the failing test**

```bash
rg -n "ensure_installed" /home/fishern2000/FishVim1.0/config/nvim/lua/fisher/plugins/lsp/mason.lua
```

Expected: missing part of target tool matrix.

**Step 2: Run test to verify it fails**

Run and inspect missing entries for core languages.

**Step 3: Write minimal implementation**

```lua
-- mason.lua ensure_installed (example)
ensure_installed = {
  "lua-language-server", "stylua",
  "pyright", "black", "isort", "ruff",
  "typescript-language-server", "eslint_d", "prettier",
  "gopls", "goimports", "golangci-lint",
  "rust-analyzer", "rustfmt",
  "bash-language-server", "shfmt",
  "json-lsp", "yamlls"
}
```

**Step 4: Run test to verify it passes**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua +qa
```

Expected: no plugin parse/setup errors.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add config/nvim/lua/fisher/plugins/lsp config/nvim/lua/fisher/plugins/formatting.lua config/nvim/lua/fisher/plugins/linting.lua
git -C /home/fishern2000/FishVim1.0 commit -m "feat: expand FishVim language tooling matrix"
```

### Task 5: Debugging and Testing Workflows

**Files:**
- Create: `config/nvim/lua/fisher/plugins/dap.lua`
- Create: `config/nvim/lua/fisher/plugins/test.lua`
- Modify: `config/nvim/lua/fisher/plugins/init.lua`
- Modify: `config/nvim/lua/fisher/core/keymaps.lua`

**Step 1: Write the failing test**

```bash
rg -n "nvim-dap|neotest" /home/fishern2000/FishVim1.0/config/nvim/lua/fisher/plugins || true
```

Expected: no robust DAP/test integration.

**Step 2: Run test to verify it fails**

Run command above and confirm empty or incomplete hits.

**Step 3: Write minimal implementation**

```lua
-- dap key examples
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Debug Continue" })
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debug Toggle Breakpoint" })

-- test key examples
vim.keymap.set("n", "<leader>tn", function() require("neotest").run.run() end, { desc = "Test Nearest" })
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Test File" })
```

**Step 4: Run test to verify it passes**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua +qa
```

Expected: no errors loading new plugin specs.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add config/nvim/lua/fisher/plugins config/nvim/lua/fisher/core/keymaps.lua
git -C /home/fishern2000/FishVim1.0 commit -m "feat: add FishVim debugging and testing workflows"
```

### Task 6: Navigation/Productivity Expansion and Legacy Alias Compatibility

**Files:**
- Modify: `config/nvim/lua/fisher/plugins/telescope.lua`
- Modify: `config/nvim/lua/fisher/plugins/which-key.lua`
- Modify: `config/nvim/lua/fisher/plugins/nvim-tree.lua`
- Modify: `config/nvim/lua/fisher/core/keymaps.lua`

**Step 1: Write the failing test**

```bash
rg -n "<leader>f|<leader>g|<leader>l|<leader>d|<leader>t" /home/fishern2000/FishVim1.0/config/nvim/lua/fisher/core/keymaps.lua
```

Expected: missing or sparse namespaced map coverage.

**Step 2: Run test to verify it fails**

Run command and verify incomplete coverage.

**Step 3: Write minimal implementation**

```lua
-- compatibility alias examples
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "LSP Restart" })
```

**Step 4: Run test to verify it passes**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua "+checkhealth" +qa
```

Expected: no fatal mapping/plugin issues.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add config/nvim/lua/fisher/plugins/telescope.lua config/nvim/lua/fisher/plugins/which-key.lua config/nvim/lua/fisher/plugins/nvim-tree.lua config/nvim/lua/fisher/core/keymaps.lua
git -C /home/fishern2000/FishVim1.0 commit -m "feat: expand navigation workflows and mapping compatibility"
```

### Task 7: README Rewrite (Full Feature and `<Space>` Command Catalog)

**Files:**
- Modify: `README.md`
- Optional Add: `docs/keymaps.md`

**Step 1: Write the failing test**

```bash
rg -n "Leader|which-key|<leader>" /home/fishern2000/FishVim1.0/README.md
```

Expected: incomplete or outdated mapping coverage.

**Step 2: Run test to verify it fails**

Run and validate missing categories/commands.

**Step 3: Write minimal implementation**

```markdown
## `<Space>` Leader Menu (which-key)

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep |
| `<leader>gg` | Open LazyGit |
| `<leader>gd` | Git diff |
| `<leader>lr` | Rename symbol |
| `<leader>la` | Code actions |
| `<leader>dc` | Debug continue |
| `<leader>db` | Toggle breakpoint |
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run file tests |
```

**Step 4: Run test to verify it passes**

```bash
rg -n "## `<Space>` Leader Menu \(which-key\)" /home/fishern2000/FishVim1.0/README.md
```

Expected: section exists and contains full table entries.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add README.md docs/keymaps.md
git -C /home/fishern2000/FishVim1.0 commit -m "docs: rewrite FishVim README with full feature and leader command guide"
```

### Task 8: Final Verification Before Completion

**Files:**
- Verify all touched files

**Step 1: Write the failing test**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua +qa
```

Expected: if any regressions remain, this fails.

**Step 2: Run test to verify it fails**

Run, observe/fix regressions until clean.

**Step 3: Write minimal implementation**
- Resolve any startup/module/keymap/README mismatches found in verification.

**Step 4: Run test to verify it passes**

```bash
nvim --headless -u /home/fishern2000/FishVim1.0/config/nvim/init.lua +qa
git -C /home/fishern2000/FishVim1.0 status --short
```

Expected: clean startup and expected staged/committed file state.

**Step 5: Commit**

```bash
git -C /home/fishern2000/FishVim1.0 add -A
git -C /home/fishern2000/FishVim1.0 commit -m "chore: finalize FishVim max modernization and docs"
```
