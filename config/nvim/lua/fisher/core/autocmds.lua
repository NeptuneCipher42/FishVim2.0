-- FishVim autocmds: quality-of-life automatic behaviors
local augroup = function(name)
  return vim.api.nvim_create_augroup("FishVim_" .. name, { clear = true })
end

-- Highlight yanked text briefly (provides visual feedback on y/yy operations)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Resize splits when the Neovim window itself is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Close certain utility windows with just `q`
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "qf", "help", "man", "notify", "lspinfo",
    "spectre_panel", "startuptime", "tsplayground",
    "PlenaryTestPopup", "checkhealth", "neotest-output",
    "neotest-summary", "neotest-output-panel",
  },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

-- Auto-restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Strip trailing whitespace on save (excludes binary/markdown where trailing spaces matter)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("strip_trailing_whitespace"),
  pattern = { "*.lua", "*.py", "*.go", "*.rs", "*.ts", "*.tsx", "*.js", "*.jsx",
              "*.css", "*.html", "*.yaml", "*.yml", "*.json", "*.toml", "*.sh" },
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Disable auto-comment continuation on new lines (very annoying default behavior)
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("no_auto_comment"),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Set filetype-specific indentation overrides
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indentation"),
  pattern = { "go" },
  callback = function()
    -- Go requires real tabs (gofmt standard)
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("python_indent"),
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Auto-create parent directories when saving a new file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(ev)
    if ev.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
