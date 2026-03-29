-- render-markdown.nvim: render markdown beautifully inside Neovim
-- 4.3k+ stars. Renders headings, code blocks, tables, checkboxes, callouts
-- in-place — no external window, only visible lines rendered (fast on large files).
-- Switches between formatted and raw view automatically when cursor enters line.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  -- Only load for markdown and AI chat buffers
  ft = { "markdown", "codecompanion", "Avante" },
  -- Guard: try to load the markdown parser; skip plugin if it fails
  cond = function()
    return pcall(vim.treesitter.language.inspect, "markdown")
  end,
  opts = function()
    local ic = require("fisher.core.icons")
    return {
    enabled = true,

    heading = {
      enabled = true,
      sign    = true,
      -- Nerd Font heading icons per level
      icons   = ic.md.headings,
      -- Color headings differently per level
      backgrounds = {
        "RenderMarkdownH1Bg", "RenderMarkdownH2Bg", "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg", "RenderMarkdownH5Bg", "RenderMarkdownH6Bg",
      },
    },

    code = {
      enabled  = true,
      sign     = false,
      style    = "full",   -- show language label + border
      border   = "thin",
      language_pad = 1,
    },

    -- Render bullet list icons
    bullet = {
      enabled = true,
      icons   = ic.md.headings,
    },

    -- Checkbox rendering (great for TODO lists)
    checkbox = {
      enabled  = true,
      unchecked = { icon = ic.md.unchecked, highlight = "RenderMarkdownUnchecked" },
      checked   = { icon = ic.md.checked, highlight = "RenderMarkdownChecked" },
      custom    = {
        todo = { raw = "[-]", rendered = ic.md.todo, highlight = "RenderMarkdownTodo" },
      },
    },

    -- Table borders
    pipe_table = {
      enabled = true,
      style   = "full",
    },

    -- Block quotes with custom icon
    quote = {
      enabled   = true,
      icon      = "▋",
      highlight = "RenderMarkdownQuote",
    },

    -- Callouts (> [!NOTE], > [!WARNING], etc.)
    callout = {
      note    = { raw = "[!NOTE]",    rendered = ic.md.note,    highlight = "RenderMarkdownInfo" },
      tip     = { raw = "[!TIP]",     rendered = ic.md.tip,     highlight = "RenderMarkdownSuccess" },
      warning = { raw = "[!WARNING]", rendered = ic.md.warning, highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = ic.md.caution, highlight = "RenderMarkdownError" },
      important = { raw = "[!IMPORTANT]", rendered = ic.md.important, highlight = "RenderMarkdownHint" },
    },

    -- Don't render virtual text on the cursor line (lets you see raw markdown)
    anti_conceal = { enabled = true },

    -- Toggle with keymap
    -- Default: <leader>um toggled in the keys below
    }
  end,
  keys = {
    {
      "<leader>um",
      function() require("render-markdown").toggle() end,
      ft = "markdown",
      desc = "Toggle markdown rendering",
    },
  },
}
