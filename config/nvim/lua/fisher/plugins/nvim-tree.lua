return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 36,
        relativenumber = true,
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        root_folder_label = ":t",
        indent_markers = { enable = true },
      },
      actions = {
        open_file = {
          quit_on_open = false,
          window_picker = { enable = false },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      update_focused_file = {
        enable = true,
      },
    })

    local map = vim.keymap.set
    map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer toggle" })
    map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Explorer current file" })
    map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Explorer collapse" })
    map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Explorer refresh" })
  end,
}
