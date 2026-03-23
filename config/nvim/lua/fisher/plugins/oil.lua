-- oil.nvim: edit filesystem like a vim buffer
-- Delete a line = delete a file. Rename a line = rename a file. :w to commit.
-- Press `-` to open parent directory. Perfect complement to nvim-tree sidebar.
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Don't lazy-load so `-` works immediately from any buffer
  lazy = false,
  opts = {
    -- Keep nvim-tree as the default explorer (oil is for editing-style navigation)
    default_file_explorer = false,

    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },

    -- Show hidden files by default
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, _)
        return name:sub(1, 1) == "."
      end,
    },

    -- Float window for quick edits
    float = {
      padding = 2,
      border = "rounded",
    },

    -- Keymaps inside oil buffers
    keymaps = {
      ["g?"]  = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"]    = "actions.parent",
      ["_"]    = "actions.open_cwd",
      ["`"]    = "actions.cd",
      ["~"]    = "actions.tcd",
      ["gs"]   = "actions.change_sort",
      ["gx"]   = "actions.open_external",
      ["g."]   = "actions.toggle_hidden",
      ["g\\"]  = "actions.toggle_trash",
    },

    use_default_keymaps = true,
  },
  keys = {
    { "-",         "<cmd>Oil<CR>",        desc = "Open parent dir (oil)" },
    { "<leader>-", "<cmd>Oil --float<CR>", desc = "Oil float window" },
  },
}
