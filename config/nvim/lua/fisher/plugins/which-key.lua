return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout    = true
    vim.o.timeoutlen = 400
  end,
  opts = function()
    local ic = require("fisher.core.icons")
    return {
    preset = "modern",
    delay  = 200,
    icons  = { group = ic.wk.group },
    spec   = {
      -- Core groups
      { "<leader>f",  group = "Find / Files" },
      { "<leader>g",  group = "Git" },
      { "<leader>l",  group = "LSP / Diagnostics" },
      { "<leader>d",  group = "Debug" },
      { "<leader>t",  group = "Test / Todo" },
      { "<leader>b",  group = "Buffers" },
      { "<leader>w",  group = "Windows / Sessions" },
      { "<leader>u",  group = "UI / Toggles" },
      { "<leader>e",  group = "Explorer" },
      { "<leader>x",  group = "Trouble Lists" },
      { "<leader>h",  group = "Hunks / Harpoon" },
      { "<leader>s",  group = "Splits / Swap" },
      -- New groups
      { "<leader>a",  group = "AI (CodeCompanion + Avante)" },
      { "<leader>av", desc = "Avante toggle sidebar" },
      { "<leader>ae", desc = "Avante ask about selection" },
      { "<leader>c",  group = "Copilot" },
      { "<leader>cp", desc = "Copilot panel" },
      { "<leader>cP", desc = "Copilot disable" },
      { "<leader>uC", desc = "Toggle Copilot auto-trigger" },
      { "<leader>R",  group = "HTTP (kulala)" },
      { "<leader>r",  group = "Rust (rustaceanvim)" },
      { "<leader>sr", desc = "Search & replace (grug-far)" },
      { "<leader>sw", desc = "Search word (grug-far)" },
      { "<leader>gC", desc = "Git conflict list" },
      { "<leader>um", desc = "Toggle markdown rendering" },
      { "<leader>gz", desc = "Zen Mode" },
      { "<leader>gB", desc = "Git Browse URL" },
      { "<leader>gd", desc = "Diffview open" },
      { "<leader>gh", desc = "File history (Diffview)" },
      { "<leader>gH", desc = "Branch history (Diffview)" },
      { "<leader>gn", desc = "Neogit (Magit-style)" },
      { "-",          desc = "Oil: open parent dir" },
      { "zR",         desc = "Open all folds (ufo)" },
      { "zM",         desc = "Close all folds (ufo)" },
      { "]]",         desc = "Next word occurrence (snacks)" },
      { "[[",         desc = "Prev word occurrence (snacks)" },
      { "]f",         desc = "Next function" },
      { "[f",         desc = "Prev function" },
      { "]c",         desc = "Next class" },
      { "[c",         desc = "Prev class" },
    },
    }
  end,
}
