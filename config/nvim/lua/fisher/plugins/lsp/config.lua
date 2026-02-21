return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = true },
      underline = true,
      virtual_text = { spacing = 2, source = "if_many" },
      signs = true,
      update_in_insert = false,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("FishVimLspAttach", { clear = true }),
      callback = function(ev)
        local b = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", b, { desc = "LSP references" }))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", b, { desc = "LSP declaration" }))
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", b, { desc = "LSP definitions" }))
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", b, { desc = "LSP implementations" }))
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", b, { desc = "LSP type definitions" }))
        vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", b, { desc = "Code actions" }))
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", b, { desc = "Rename symbol" }))
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", b, { desc = "Line diagnostics" }))
        vim.keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", vim.tbl_extend("force", b, { desc = "Buffer diagnostics" }))
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", b, { desc = "Prev diagnostic" }))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", b, { desc = "Next diagnostic" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", b, { desc = "Hover docs" }))
        vim.keymap.set("n", "<leader>ls", "<cmd>LspRestart<CR>", vim.tbl_extend("force", b, { desc = "Restart LSP" }))
      end,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for kind, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. kind
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local server_overrides = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
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
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
          })
        end,
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
