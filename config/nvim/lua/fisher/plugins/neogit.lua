-- neogit: Magit-style interactive git UI for Neovim
-- Provides: interactive staging, commit, rebase, log, stash, push/pull
-- Integrates with diffview.nvim for inline diffs
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<CR>", desc = "Neogit (Magit-style)" },
  },
  opts = {
    -- Use diffview for inline diffs inside neogit
    integrations = {
      diffview = true,
      telescope = true,
    },
    -- Keep UI minimal and fast
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    commit_popup = {
      kind = "split",
    },
    popup = {
      kind = "split",
    },
    signs = {
      hunk  = { "", "" },
      item  = { ">", "v" },
      section = { ">", "v" },
    },
  },
}
