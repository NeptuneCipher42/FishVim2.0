-- codecompanion.nvim: AI coding assistant with Claude, GPT, Gemini, Ollama support
-- Features: inline edits, chat interface, agent mode with tool use, Cursor-like experience
-- Setup: set ANTHROPIC_API_KEY env var for Claude (default adapter)
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionActions",
    "CodeCompanionToggle",
  },
  keys = {
    { "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>",   mode = { "n", "v" }, desc = "AI Chat toggle" },
    { "<leader>aa", "<cmd>CodeCompanionActions<CR>",       mode = { "n", "v" }, desc = "AI Actions" },
    { "<leader>ac", "<cmd>CodeCompanion<CR>",             mode = { "n", "v" }, desc = "AI Inline assistant" },
    { "<leader>ae", "<cmd>CodeCompanionChat Add<CR>",      mode = "v",          desc = "AI Add selection to chat" },
  },
  opts = {
    -- Default to Claude Sonnet (set ANTHROPIC_API_KEY in your shell profile)
    strategies = {
      chat   = { adapter = "anthropic" },
      inline = { adapter = "anthropic" },
      agent  = { adapter = "anthropic" },
    },
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = { api_key = "ANTHROPIC_API_KEY" },
          schema = {
            model = {
              default = "claude-sonnet-4-6-20251101",
            },
          },
        })
      end,
    },
    display = {
      chat = {
        window = {
          layout = "vertical",
          width = 0.35,
        },
        render_headers = true,
        show_settings = true,
        show_token_count = true,
      },
      inline = {
        layout = "vertical",
        diff = {
          enabled = true,
          close_chat_at = 240,
          layout = "vertical",
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
        },
      },
    },
    opts = {
      log_level = "ERROR",
      send_code = true,
    },
  },
}
