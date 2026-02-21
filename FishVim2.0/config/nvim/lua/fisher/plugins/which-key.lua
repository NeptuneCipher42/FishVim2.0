return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 400
  end,
  opts = {
    preset = "modern",
    delay = 200,
    icons = { group = "󰘳 " },
    spec = {
      { "<leader>f", group = "Find / Files" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP / Diagnostics" },
      { "<leader>d", group = "Debug" },
      { "<leader>t", group = "Test / Todo" },
      { "<leader>b", group = "Buffers" },
      { "<leader>w", group = "Windows / Sessions" },
      { "<leader>u", group = "UI / Toggles" },
      { "<leader>e", group = "Explorer" },
      { "<leader>x", group = "Trouble Lists" },
      { "<leader>h", group = "Hunks / Harpoon" },
    },
  },
}
