return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        progress = { enabled = true },
        signature = { enabled = true },
        hover = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2500,
      stages = "slide",
      background_colour = "#000000",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 14,
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "rounded" },
    },
    keys = {
      { "<leader>ut", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      { "<leader>ug", "<cmd>TermExec cmd='lazygit'<CR>", desc = "Terminal lazygit" },
    },
  },
}
