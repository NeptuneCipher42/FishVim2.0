return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Automatically disable heavy features on large files
    bigfile = { enabled = true },

    -- Enhanced indent guides (replaces indent-blankline.nvim)
    indent = {
      enabled = true,
      animate = { enabled = true, style = "down" },
      chunk = { enabled = true },
      indent = { char = "┊" },
      scope = { char = "┊", hl = "SnacksIndentScope" },
    },

    -- Better vim.ui.input/select (replaces dressing.nvim)
    input = { enabled = true },

    -- Notification history viewer (keeps nvim-notify for display)
    notifier = { enabled = false },

    -- LazyGit integration (keep lazygit.nvim for keymaps, snacks provides extra)
    lazygit = { enabled = true },

    -- Open git URLs in browser
    gitbrowse = { enabled = true },

    -- LSP-aware file rename
    rename = { enabled = true },

    -- Highlight word under cursor across all windows
    words = { enabled = true, debounce = 200 },

    -- Smooth scrolling
    scroll = { enabled = true, animate = { easing = "linear", duration = { step = 10, total = 100 } } },

    -- Better statuscolumn (signs, line numbers, folds)
    statuscolumn = { enabled = true },

    -- Smooth UI animations
    animate = { enabled = true },

    -- Scope context highlight
    scope = { enabled = true },

    -- Zen / focus mode
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = false,
        inlay_hints = false,
      },
      win = { style = "zen", width = 120 },
    },

    -- Keep these disabled (using dedicated plugins instead)
    dashboard = { enabled = false },  -- keep alpha-nvim
    terminal  = { enabled = false },  -- keep toggleterm
    picker    = { enabled = false },  -- keep telescope
    explorer  = { enabled = false },  -- keep nvim-tree + oil
  },
  keys = {
    { "<leader>gz", function() Snacks.zen() end,                            desc = "Zen Mode" },
    { "<leader>gB", function() Snacks.gitbrowse() end,                     desc = "Git Browse URL" },
    { "<leader>N",  function() Snacks.notifier.show_history() end,         desc = "Notification History" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,        desc = "Next word occurrence", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end,       desc = "Prev word occurrence", mode = { "n", "t" } },
  },
}
