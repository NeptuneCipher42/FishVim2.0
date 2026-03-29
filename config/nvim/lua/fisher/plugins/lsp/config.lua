return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- blink.cmp provides LSP capabilities (replaces cmp-nvim-lsp)
    "saghen/blink.cmp",
    -- LSP-aware file rename/move operations
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- lazydev: Neovim Lua API completion (replaces deprecated neodev.nvim)
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim",        words = { "Snacks" } },
        },
      },
    },
  },
  config = function()
    local lspconfig      = require("lspconfig")
    local ic             = require("fisher.core.icons")
    local mason_lspconfig = require("mason-lspconfig")

    -- Get blink.cmp extended capabilities (tells servers we support rich completion)
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Diagnostics: modern config compatible with Neovim 0.10+
    vim.diagnostic.config({
      severity_sort    = true,
      float            = { border = "rounded", source = true },
      underline        = true,
      virtual_text     = false,   -- tiny-inline-diagnostic.nvim handles rendering
      -- Neovim 0.11: show virtual_lines only on current line (less noise)
      virtual_lines    = { current_line = true },
      signs            = {
        text = {
          [vim.diagnostic.severity.ERROR] = ic.diag.error,
          [vim.diagnostic.severity.WARN]  = ic.diag.warn,
          [vim.diagnostic.severity.HINT]  = ic.diag.hint,
          [vim.diagnostic.severity.INFO]  = ic.diag.info,
        },
      },
      update_in_insert = false,
    })

    -- LspAttach: set buffer-local keymaps when a language server attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("FishVimLspAttach", { clear = true }),
      callback = function(ev)
        local b = { buffer = ev.buf, silent = true }
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", b, { desc = desc }))
        end

        bmap("n",      "gR",         "<cmd>Telescope lsp_references<CR>",      "LSP references")
        bmap("n",      "gD",         vim.lsp.buf.declaration,                  "LSP declaration")
        bmap("n",      "gd",         "<cmd>Telescope lsp_definitions<CR>",     "LSP definitions")
        bmap("n",      "gi",         "<cmd>Telescope lsp_implementations<CR>", "LSP implementations")
        bmap("n",      "gt",         "<cmd>Telescope lsp_type_definitions<CR>","LSP type definitions")
        bmap({ "n","v" },"<leader>la", vim.lsp.buf.code_action,               "Code actions")
        -- <leader>lr handled by inc-rename.nvim (live preview rename)
        -- Fallback if inc-rename is not loaded:
        bmap("n",      "<leader>lr", vim.lsp.buf.rename,                      "Rename symbol (fallback)")
        bmap("n",      "<leader>ld", vim.diagnostic.open_float,               "Line diagnostics")
        bmap("n",      "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>","Buffer diagnostics")
        bmap("n",      "[d",         vim.diagnostic.goto_prev,                "Prev diagnostic")
        bmap("n",      "]d",         vim.diagnostic.goto_next,                "Next diagnostic")
        -- K is handled by ufo.lua (peek fold → hover fallback)
        bmap("n",      "<leader>ls", "<cmd>LspRestart<CR>",                   "Restart LSP")
        bmap("n",      "<leader>li", "<cmd>LspInfo<CR>",                      "LSP info")

        -- Enable inlay hints if the server supports them (Neovim 0.10+)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
          bmap("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
          end, "Toggle inlay hints")
        end
      end,
    })

    -- Per-server overrides: only supply non-default settings
    local server_overrides = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion  = { callSnippet = "Replace" },
            workspace   = { checkThirdParty = false },
          },
        },
      },
      emmet_ls = {
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      },
      graphql = {
        filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
      },
      svelte = {
        on_attach = function(client)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern  = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
          })
        end,
      },
      -- clangd: disable proto files (handled by buf LSP)
      clangd = {
        capabilities = vim.tbl_deep_extend("force", capabilities, {
          offsetEncoding = { "utf-16" },
        }),
      },
      -- pyright: strict type checking mode
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
              autoImportCompletions = true,
            },
          },
        },
      },
    }

    mason_lspconfig.setup_handlers({
      function(server)
        local conf = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, server_overrides[server] or {})
        lspconfig[server].setup(conf)
      end,
    })
  end,
}
