vim.cmd("let g:netrw_liststyle = 3")

-- Windows: force UTF-8 so Nerd Font glyphs are not mangled by the console code page
if vim.fn.has("win32") == 1 then
  vim.opt.encoding     = "utf-8"
  vim.opt.fileencoding = "utf-8"
  -- Tell Neovim the host shell is UTF-8 aware (needed when launched from PowerShell)
  vim.env.PYTHONIOENCODING = "utf-8"
end

local opt = vim.opt

-- UI
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true
opt.signcolumn     = "yes"
opt.termguicolors  = true
opt.background     = "dark"
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.wrap           = false
opt.laststatus     = 3
opt.showmode       = false

-- Tabs / indentation
opt.tabstop     = 2
opt.shiftwidth  = 2
opt.softtabstop = 2
opt.expandtab   = true
opt.smartindent = true
opt.autoindent  = true

-- Search
opt.ignorecase = true
opt.smartcase  = true
opt.incsearch  = true
opt.hlsearch   = true

-- Clipboard / completion
opt.clipboard:append("unnamedplus")
opt.completeopt = { "menu", "menuone", "noselect" }

-- Command line completion (wilder.nvim enhances this further)
opt.wildmenu       = true                    -- enable built-in completion menu
opt.wildmode       = { "longest:full", "full" } -- first complete longest match, then cycle
opt.wildoptions    = "pum"                   -- use popup menu (same style as insert completion)
opt.wildignorecase = true                    -- case-insensitive command completion
opt.wildignore     = {                       -- skip these in file completion
  "*.o", "*.obj", "*.pyc", "*.class",
  ".git", ".hg", ".svn",
  "node_modules", ".DS_Store",
  "*.jpg", "*.png", "*.gif", "*.svg",
}

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Files
opt.swapfile   = false
opt.backup     = false
opt.undofile   = true
opt.updatetime = 250
opt.timeoutlen = 400

-- Code folding — required by nvim-ufo for LSP/Treesitter-backed folds
-- foldlevel 99 = all folds open by default; nvim-ufo manages actual fold depth
opt.foldcolumn     = "1"
opt.foldlevel      = 99
opt.foldlevelstart = 99
opt.foldenable     = true

-- Whitespace rendering (activate with :set list)
opt.listchars = {
  tab   = "» ",
  trail = "·",
  nbsp  = "␣",
}

-- Keep backspace intuitive in insert mode
opt.backspace = "indent,eol,start"
