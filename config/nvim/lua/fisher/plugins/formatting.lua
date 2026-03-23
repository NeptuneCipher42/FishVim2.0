return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt" },
      },
      format_on_save = function(bufnr)
        local ignore = { ["neo-tree"] = true }
        if ignore[vim.bo[bufnr].filetype] then
          return
        end
        return { timeout_ms = 1500, lsp_fallback = true }
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({ async = false, timeout_ms = 1500, lsp_fallback = true })
    end, { desc = "Format file/range" })
  end,
}
