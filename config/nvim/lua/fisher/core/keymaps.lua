vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

local function n(lhs, rhs, desc)
  map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

local function normal_if_editable(keys)
  return function()
    if not vim.bo.modifiable or vim.bo.readonly then
      vim.notify("Buffer is not editable", vim.log.levels.WARN)
      return
    end
    vim.cmd("normal! " .. keys)
  end
end

-- ─────────────────────────────────────────────────────────
--  Escape / Save / Quit
-- ─────────────────────────────────────────────────────────
map("i",           "jk",    "<Esc>",     { desc = "Exit insert mode",    noremap = true, silent = true })
map({ "n","i","v" },"<C-s>","<cmd>w<CR>",{ desc = "Write file",          noremap = true, silent = true })
map("n",           "<C-q>", "<cmd>qa<CR>",{ desc = "Quit all",           noremap = true, silent = true })

-- ─────────────────────────────────────────────────────────
--  Core actions
-- ─────────────────────────────────────────────────────────
n("<leader>ww",  "<cmd>w<CR>",            "Write file")
n("<leader>qq",  "<cmd>qa<CR>",           "Quit all")
n("<leader>nh",  "<cmd>nohlsearch<CR>",   "Clear search highlight")
n("<leader>+",   normal_if_editable("<C-a>"), "Increment number")
n("<leader>-",   normal_if_editable("<C-x>"), "Decrement number")

-- ─────────────────────────────────────────────────────────
--  Window management
-- ─────────────────────────────────────────────────────────
n("<leader>sv",  "<C-w>v",              "Split vertical")
n("<leader>sh",  "<C-w>s",              "Split horizontal")
n("<leader>se",  "<C-w>=",              "Equalize splits")
n("<leader>sx",  "<cmd>close<CR>",      "Close split")
n("<leader>sm",  "<cmd>MaximizerToggle<CR>", "Toggle maximizer")

n("<leader>wa",  "<C-w>h", "Window left")
n("<leader>ws",  "<C-w>j", "Window down")
n("<leader>wd",  "<C-w>l", "Window right")
n("<leader>wq",  "<C-w>k", "Window up")

-- Tabs
n("<leader>wo",  "<cmd>tabnew<CR>",     "New tab")
n("<leader>wx",  "<cmd>tabclose<CR>",   "Close tab")
n("<leader>wn",  "<cmd>tabn<CR>",       "Next tab")
n("<leader>wp",  "<cmd>tabp<CR>",       "Prev tab")
n("<leader>wf",  "<cmd>tabnew %<CR>",   "Buffer in new tab")
n("<leader>wS",  "<cmd>SessionSave<CR>","Save session")
n("<leader>wr",  "<cmd>SessionRestore<CR>", "Restore session")

-- ─────────────────────────────────────────────────────────
--  Window navigation without leader (Ctrl-hjkl, tmux-safe)
-- ─────────────────────────────────────────────────────────
n("<C-h>", "<C-w>h", "Window left")
n("<C-j>", "<C-w>j", "Window down")
n("<C-k>", "<C-w>k", "Window up")
n("<C-l>", "<C-w>l", "Window right")

-- ─────────────────────────────────────────────────────────
--  Quick one-key leader shortcuts (preserve muscle memory)
-- ─────────────────────────────────────────────────────────
n("<leader>\\",  "<C-w>v",              "Split vertical (quick)")
n("<leader>_",   "<C-w>s",             "Split horizontal (quick)")
n("<leader>]",   "<cmd>tabn<CR>",       "Next tab (quick)")
n("<leader>[",   "<cmd>tabp<CR>",       "Prev tab (quick)")
n("<leader>.",   "<cmd>BufferLineCycleNext<CR>", "Next buffer")
n("<leader>,",   "<cmd>BufferLineCyclePrev<CR>", "Prev buffer")

-- Legacy window aliases (old muscle memory)
n("<leader>a",   "<C-w>h", "Window left (legacy)")
n("<leader>s",   "<C-w>j", "Window down (legacy)")
n("<leader>d",   "<C-w>l", "Window right (legacy)")
n("<leader>q",   "<C-w>k", "Window up (legacy)")
n("<leader>c",   "<cmd>close<CR>",  "Close current split")
n("<leader>o",   "<cmd>only<CR>",   "Close other splits")
n("<leader>n",   "<cmd>tabn<CR>",   "Next tab (legacy)")
n("<leader>p",   "<cmd>tabp<CR>",   "Prev tab (legacy)")
n("<leader>C",   "<cmd>tabclose<CR>","Close tab (legacy)")
n("<leader>h",   "<C-w>h",          "Window left (quick)")
n("<leader>j",   "<C-w>j",          "Window down (quick)")
n("<leader>k",   "<C-w>k",          "Window up (quick)")
n("<leader>L",   "<C-w>l",          "Window right (quick)")

-- ─────────────────────────────────────────────────────────
--  Quick roots — single keypress opens most-used action
--  (which-key groups still work: press and wait for popup)
-- ─────────────────────────────────────────────────────────
n("<leader><space>", "<cmd>Telescope find_files<CR>",  "Find files (quick)")
n("<leader>f",       "<cmd>Telescope find_files<CR>",  "Files / Find")
n("<leader>g",       "<cmd>LazyGit<CR>",               "Git")
n("<leader>l",       "<cmd>Trouble diagnostics toggle<CR>", "LSP / Diagnostics")
n("<leader>b",       "<cmd>BufferLinePick<CR>",         "Buffers")
n("<leader>u",       "<cmd>set invrelativenumber<CR>",  "UI toggles")

-- ─────────────────────────────────────────────────────────
--  UI toggles
-- ─────────────────────────────────────────────────────────
n("<leader>ut",  "<cmd>ToggleTerm<CR>",    "Toggle terminal")
n("<leader>ug",  "<cmd>TermExec cmd='lazygit'<CR>", "LazyGit in terminal")
n("<leader>uw",  "<cmd>set invwrap<CR>",   "Toggle word wrap")
n("<leader>us",  "<cmd>set invspell<CR>",  "Toggle spellcheck")

-- ─────────────────────────────────────────────────────────
--  Formatting
-- ─────────────────────────────────────────────────────────
n("<leader>mp",  function()
  require("conform").format({ async = true, lsp_fallback = true })
end, "Format file")

-- ─────────────────────────────────────────────────────────
--  Oil.nvim — buffer-based file manager
-- ─────────────────────────────────────────────────────────
-- Note: `-` key also mapped in oil.lua via `keys = {}`
n("<leader>eo",  "<cmd>Oil<CR>",        "Oil file manager")
n("<leader>eO",  "<cmd>Oil --float<CR>","Oil float window")

-- ─────────────────────────────────────────────────────────
--  Git extras (diffview + neogit + snacks)
-- ─────────────────────────────────────────────────────────
-- Diffview keys are in diffview.lua, neogit in neogit.lua, lazygit in git.lua
-- snacks zen/gitbrowse in snacks.lua — all use lazy keys = {} spec

-- ─────────────────────────────────────────────────────────
--  AI (CodeCompanion) — keys in codecompanion.lua via lazy keys = {}
-- ─────────────────────────────────────────────────────────
-- <leader>ai  = AI Chat
-- <leader>aa  = AI Actions
-- <leader>ac  = AI Inline

-- ─────────────────────────────────────────────────────────
--  Fold controls (nvim-ufo) — keys in ufo.lua via lazy keys = {}
-- ─────────────────────────────────────────────────────────
-- zR = open all folds
-- zM = close all folds
-- zr = fold less
-- zm = fold more
-- K  = peek fold / hover docs
