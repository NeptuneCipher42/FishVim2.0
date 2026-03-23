-- diffview.nvim: full-screen tabpage for diffs, file history, branch comparisons
-- Essential for code review workflows directly inside Neovim
return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
    "DiffviewRefresh",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>",             desc = "Diffview open" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>",    desc = "File git history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>",      desc = "Branch git history" },
    { "<leader>gx", "<cmd>DiffviewClose<CR>",            desc = "Diffview close" },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        layout = "diff3_horizontal",
        disable_diagnostics = true,
      },
    },
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 35,
      },
    },
    hooks = {
      diff_buf_read = function(_)
        -- Disable certain features in diff buffers for clarity
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.colorcolumn = ""
      end,
    },
  },
}
