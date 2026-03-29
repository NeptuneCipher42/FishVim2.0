-- Central icon registry for FishVim
-- On Windows the Nerd Font private-use-area glyphs (U+E000–U+F8FF) only render
-- when the terminal font is a Nerd Font.  The bootstrap script sets
-- "Cascadia Code NF" in Windows Terminal automatically, but if glyphs still
-- don't appear, set NVIM_NERD_FONT=0 in your environment to use plain fallbacks.

local M = {}

local is_win = vim.fn.has("win32") == 1

-- Auto-detect: Windows defaults to safe mode unless the user opts in via env var.
-- On Linux/macOS Nerd Fonts are assumed present (same as before).
local nf = not is_win or vim.env.NVIM_NERD_FONT == "1"

-- ── Diagnostics ──────────────────────────────────────────────────────────────
M.diag = {
  error = nf and " "  or "E ",
  warn  = nf and " "  or "W ",
  info  = nf and " "  or "I ",
  hint  = nf and "󰠠 " or "H ",
}

-- ── Git ───────────────────────────────────────────────────────────────────────
M.git = {
  branch   = nf and ""   or "BR",
  added    = nf and " " or "+",
  modified = nf and " " or "~",
  removed  = nf and " " or "-",
}

-- ── Files ─────────────────────────────────────────────────────────────────────
M.file = {
  generic = nf and "" or "F",
  folder  = nf and "" or "D",
}

-- ── OS / format ──────────────────────────────────────────────────────────────
M.os = {
  unix = nf and "" or "L",
  dos  = nf and "" or "W",
  mac  = nf and "" or "M",
}

-- ── Lualine separators ────────────────────────────────────────────────────────
M.sep = {
  -- section (filled triangle)
  section_left  = nf and "" or "",
  section_right = nf and "" or "",
  -- component (thin chevron)
  comp_left  = nf and "" or "|",
  comp_right = nf and "" or "|",
}

-- ── Dashboard (alpha) ─────────────────────────────────────────────────────────
M.dash = {
  new_file = nf and ""   or "+",
  find     = nf and ""   or "?",
  grep     = nf and "󰱼 " or "/ ",
  project  = nf and ""   or "P",
  session  = nf and ""   or "~",
  explorer = nf and ""   or "E",
  mason    = nf and "󰏔 " or "M ",
  lazy     = nf and "󰒲 " or "L ",
  quit     = nf and "󰅚 " or "Q",
}

-- ── which-key ────────────────────────────────────────────────────────────────
M.wk = {
  group = nf and "󰘳 " or "+ ",
}

-- ── Noice cmdline ─────────────────────────────────────────────────────────────
M.noice = {
  lua = nf and "" or ">",
}

-- ── render-markdown ───────────────────────────────────────────────────────────
M.md = {
  -- heading icons per level
  headings   = nf
    and { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " }
    or  { "# ", "## ", "### ", "#### ", "##### ", "###### " },
  -- checkboxes
  unchecked  = nf and "󰄱 "  or "[ ] ",
  checked    = nf and "󰱒 "  or "[x] ",
  todo       = nf and "󰥔 "  or "[-] ",
  -- callouts
  note       = nf and "󰋽 Note"      or "i Note",
  tip        = nf and "󰌶 Tip"       or "* Tip",
  warning    = nf and "󰀪 Warning"   or "! Warning",
  caution    = nf and "󰳦 Caution"   or "x Caution",
  important  = nf and "󰅾 Important" or "! Important",
}

return M
