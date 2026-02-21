vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function n(lhs, rhs, desc)
  map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

-- Insert mode escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode", noremap = true, silent = true })

-- Core actions
n("<leader>ww", "<cmd>w<CR>", "Write file")
n("<leader>qq", "<cmd>qa<CR>", "Quit all")
n("<leader>nh", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Number ops
n("<leader>+", "<C-a>", "Increment number")
n("<leader>-", "<C-x>", "Decrement number")

-- Window management
n("<leader>sv", "<C-w>v", "Split vertical")
n("<leader>sh", "<C-w>s", "Split horizontal")
n("<leader>se", "<C-w>=", "Equalize splits")
n("<leader>sx", "<cmd>close<CR>", "Close split")
n("<leader>sm", "<cmd>MaximizerToggle<CR>", "Toggle split maximizer")

-- Window navigation
n("<leader>wa", "<C-w>h", "Window left")
n("<leader>ws", "<C-w>j", "Window down")
n("<leader>wd", "<C-w>l", "Window right")
n("<leader>wq", "<C-w>k", "Window up")

-- Legacy aliases to preserve old muscle memory
n("<leader>a", "<C-w>h", "Window left (legacy)")
n("<leader>s", "<C-w>j", "Window down (legacy)")
n("<leader>d", "<C-w>l", "Window right (legacy)")
n("<leader>q", "<C-w>k", "Window up (legacy)")

-- Tabs
n("<leader>wo", "<cmd>tabnew<CR>", "Tab new")
n("<leader>wx", "<cmd>tabclose<CR>", "Tab close")
n("<leader>wn", "<cmd>tabn<CR>", "Tab next")
n("<leader>wp", "<cmd>tabp<CR>", "Tab previous")
n("<leader>wf", "<cmd>tabnew %<CR>", "Buffer in new tab")

-- Quick roots for which-key visibility
n("<leader>f", "<cmd>Telescope find_files<CR>", "Files")
n("<leader>g", "<cmd>LazyGit<CR>", "Git")
n("<leader>l", "<cmd>Trouble diagnostics toggle<CR>", "LSP/Diagnostics")
n("<leader>b", "<cmd>BufferLinePick<CR>", "Buffers")
n("<leader>u", "<cmd>set invrelativenumber<CR>", "UI toggles")
