-- blink.cmp: next-gen completion engine (replaces nvim-cmp + 5 source plugins)
-- Rust-based fuzzy matching, 6x faster, typo-resistant, built-in LSP/path/buffer/snippets
return {
  "saghen/blink.cmp",
  version = "v0.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "default",
      -- Match previous nvim-cmp muscle memory
      ["<C-k>"]     = { "select_prev", "fallback" },
      ["<C-j>"]     = { "select_next", "fallback" },
      ["<C-b>"]     = { "scroll_documentation_up", "fallback" },
      ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"]     = { "hide", "fallback" },
      ["<CR>"]      = { "accept", "fallback" },
      ["<Tab>"]     = { "snippet_forward", "fallback" },
      ["<S-Tab>"]   = { "snippet_backward", "fallback" },
    },

    appearance = {
      use_nvim_web_devicons = true,
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- Built-in signature help (replaces separate signature plugin)
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
          },
        },
      },
      ghost_text = { enabled = true },
    },
  },
}
