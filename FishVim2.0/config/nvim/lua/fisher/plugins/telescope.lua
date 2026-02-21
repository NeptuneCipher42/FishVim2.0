return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-project.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        ["ui-select"] = require("telescope.themes").get_dropdown({}),
      },
    })

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "project")

    local map = vim.keymap.set
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Grep project" })
    map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Cursor word" })
    map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    map("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "Projects" })
    map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
  end,
}
