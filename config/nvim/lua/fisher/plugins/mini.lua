-- mini.nvim: collection of minimal, independent Lua modules
-- Adding only the best ones that don't conflict with existing plugins:
--   mini.ai    → enhanced a/i text objects (va), vi", va, for function args)
--   mini.icons → faster icon provider, replaces nvim-web-devicons API
return {
  {
    -- Enhanced text objects: adds function args, classes, blocks, and more
    -- Works transparently with existing v/d/c/y operations
    "echasnovski/mini.ai",
    version = "*",
    event = "VeryLazy",
    opts = {
      n_lines = 500,  -- search within 500 lines for text objects
      -- Custom text objects in addition to defaults:
      -- va) = around function call args, vi" = inside string, etc.
    },
  },
  {
    -- Faster icon provider with broader coverage than nvim-web-devicons
    -- Mocks nvim-web-devicons API so all plugins get icons automatically
    "echasnovski/mini.icons",
    version = "*",
    lazy = true,
    init = function()
      -- Replace nvim-web-devicons globally so all plugins use mini.icons
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = {
      -- "glyph" uses Nerd Font private-use-area codepoints (requires a Nerd Font
      -- in your terminal). Set to "ascii" only if icons still don't render after
      -- installing a Nerd Font and restarting the terminal.
      style = "glyph",
    },
  },
}
