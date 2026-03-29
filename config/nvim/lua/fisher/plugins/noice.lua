-- noice.nvim: fully replaces wilder.nvim + upgrades cmdline, messages, and notifications
-- Renders the : / ? cmdline as a floating popup with icons and completion
-- Routes LSP messages, search counts, and write notifications cleanly
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = function()
    local ic = require("fisher.core.icons")
    return {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",   -- floating popup, not inline at bottom
      format = {
        cmdline     = { icon = ">" },
        search_down = { icon = " " },
        search_up   = { icon = " " },
        filter      = { icon = "$" },
        lua         = { icon = ic.noice.lua },
        help        = { icon = "?" },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"]                = true,
      },
      signature = { enabled = false },   -- blink.cmp handles signature help
    },
    presets = {
      bottom_search        = false,  -- keep our floating popup
      command_palette      = true,   -- position cmdline popup like a palette
      long_message_to_split = true,  -- long messages go to split instead of popup
      inc_rename           = true,   -- inc-rename.nvim integration
    },
    routes = {
      -- Suppress noisy "written" / "fewer lines" / "more lines" messages
      { filter = { event = "msg_show", kind = "",            find = "written"     }, opts = { skip = true } },
      { filter = { event = "msg_show", kind = "",            find = "fewer lines" }, opts = { skip = true } },
      { filter = { event = "msg_show", kind = "",            find = "more lines"  }, opts = { skip = true } },
      { filter = { event = "msg_show", kind = "search_count"                      }, opts = { skip = true } },
    },
    views = {
      cmdline_popup = {
        border = { style = "rounded" },
        position = { row = "40%", col = "50%" },
        size     = { width = 60, height = "auto" },
      },
      popupmenu = {
        relative  = "editor",
        position  = { row = "50%", col = "50%" },
        size      = { width = 60, height = 10 },
        border    = { style = "rounded" },
        win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
      },
    },
    }
  end,
  keys = {
    { "<leader>nl", function() require("noice").cmd("last")    end, desc = "Noice: last message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice: message history" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Noice: dismiss all" },
    {
      "<C-f>", function()
        if not require("noice.lsp").scroll(4) then return "<C-f>" end
      end,
      silent = true, expr = true, desc = "Scroll noice doc down", mode = { "i", "n", "s" },
    },
    {
      "<C-b>", function()
        if not require("noice.lsp").scroll(-4) then return "<C-b>" end
      end,
      silent = true, expr = true, desc = "Scroll noice doc up", mode = { "i", "n", "s" },
    },
  },
}
