return {
  "nvim-treesitter/nvim-treesitter", -- Treesitter for better syntax highlighting and code parsing
  event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file
  build = ":TSUpdate", -- Automatically update Treesitter parsers
  dependencies = {
    "windwp/nvim-ts-autotag", -- Auto-close and rename HTML/XML tags
  },
  config = function()
    -- Guard against partial/missing install so startup doesn't hard-fail.
    local ok, treesitter = pcall(require, "nvim-treesitter.configs")
    if not ok then
      vim.schedule(function()
        vim.notify(
          "nvim-treesitter is not available yet. Run :Lazy sync and restart Neovim.",
          vim.log.levels.WARN
        )
      end)
      return
    end

    -- Configure Treesitter
    treesitter.setup({
      -- Enable syntax highlighting
      highlight = { enable = true },

      -- Enable automatic indentation
      indent = { enable = true },

      -- Enable automatic tag closing (requires nvim-ts-autotag)
      autotag = { enable = true },

      -- Install these language parsers automatically
      ensure_installed = {
        "json", "javascript", "typescript", "tsx", "yaml", "html", "css",
        "markdown", "markdown_inline", "svelte", "graphql", "bash",
        "lua", "vim", "dockerfile", "gitignore", "query", "vimdoc", "c"
      },

      -- Enable incremental selection (expands syntax tree selections)
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>", -- Start incremental selection
          node_incremental = "<C-space>", -- Expand to the next node
          scope_incremental = false, -- Disable scope selection
          node_decremental = "<bs>", -- Shrink selection
        },
      },
    })
  end,
}
