return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      session_lens = { load_on_setup = true },
    })

    vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session (cwd)" })
    vim.keymap.set("n", "<leader>wS", "<cmd>SessionSave<CR>", { desc = "Save session (cwd)" })
  end,
}
