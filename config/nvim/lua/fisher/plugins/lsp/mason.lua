return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        -- Web
        "bashls",
        "cssls",
        "emmet_ls",
        "graphql",
        "html",
        "jsonls",
        "svelte",
        "ts_ls",
        "yamlls",
        -- Systems / Backend
        "clangd",       -- C/C++ (new)
        "dockerls",
        "gopls",        -- Go
        "lua_ls",
        "pyright",      -- Python
        "rust_analyzer",-- Rust
        "taplo",        -- TOML
        -- Docs
        "marksman",     -- Markdown (new)
      },
      -- Use ensure_installed, not automatic_installation (deprecated in mason-lspconfig v2)
      automatic_installation = false,
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Python
        "black",
        "isort",
        "ruff",
        "debugpy",
        -- JavaScript / TypeScript
        "eslint_d",
        "prettier",
        -- Go
        "goimports",
        "golangci-lint",
        -- Lua
        "stylua",
        "luacheck",     -- was missing, now added
        -- Shell
        "shfmt",
        "shellcheck",
        -- C/C++ DAP
        "codelldb",
      },
      auto_update      = false,
      run_on_start     = true,
      start_delay      = 3000,
      debounce_hours   = 24,
    })
  end,
}
