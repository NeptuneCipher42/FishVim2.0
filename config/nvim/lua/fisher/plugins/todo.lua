return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function(_, opts)
    local todo = require("todo-comments")
    todo.setup(opts)

    vim.keymap.set("n", "]t", function()
      todo.jump_next()
    end, { desc = "Next todo" })

    vim.keymap.set("n", "[t", function()
      todo.jump_prev()
    end, { desc = "Prev todo" })

    vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" })
    vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Todo Trouble" })
  end,
}
