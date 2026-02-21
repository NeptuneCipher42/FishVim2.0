vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.laststatus = 3
opt.showmode = false

-- Tabs / indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Clipboard / completion
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 400

-- Better whitespace rendering options are available via :set list
opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Keep backspace behavior intuitive in insert mode
opt.backspace = "indent,eol,start"
