return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.schedule(function()
          vim.notify("nvim-treesitter not available. Run :Lazy sync and restart.", vim.log.levels.WARN)
        end)
        return
      end

      treesitter.setup({
        highlight  = { enable = true },
        indent     = { enable = true },
        autotag    = { enable = true },

        -- All parsers with full LSP/DAP/test stacks — now complete
        ensure_installed = {
          -- Web stack
          "javascript", "typescript", "tsx", "jsx",
          "html", "css", "json", "graphql", "svelte",
          -- Systems
          "go",          -- new: gopls + neotest-go + goimports
          "rust",        -- new: rust_analyzer + codelldb
          "c",           -- new: clangd + codelldb
          "python",      -- new: pyright + debugpy + neotest-python
          -- Config / Data
          "toml",        -- new: taplo
          "yaml", "dockerfile", "gitignore",
          -- Scripting
          "lua", "vim", "vimdoc", "bash",
          -- Docs
          "markdown", "markdown_inline",
          -- Meta
          "query",
        },

        -- Incremental selection (expand/shrink syntax-tree selections)
        incremental_selection = {
          enable  = true,
          keymaps = {
            init_selection    = "<C-space>",
            node_incremental  = "<C-space>",
            scope_incremental = false,
            node_decremental  = "<bs>",
          },
        },

        -- Text objects via nvim-treesitter-textobjects
        -- Adds: af/if (function), ac/ic (class/comment), aa/ia (arg), al/il (loop)
        textobjects = {
          select = {
            enable    = true,
            lookahead = true,  -- jump to next object automatically
            keymaps   = {
              ["af"] = { query = "@function.outer", desc = "Around function" },
              ["if"] = { query = "@function.inner", desc = "Inside function" },
              ["ac"] = { query = "@class.outer",    desc = "Around class" },
              ["ic"] = { query = "@class.inner",    desc = "Inside class" },
              ["aa"] = { query = "@parameter.outer",desc = "Around argument" },
              ["ia"] = { query = "@parameter.inner",desc = "Inside argument" },
              ["al"] = { query = "@loop.outer",     desc = "Around loop" },
              ["il"] = { query = "@loop.inner",     desc = "Inside loop" },
              ["ab"] = { query = "@block.outer",    desc = "Around block" },
              ["ib"] = { query = "@block.inner",    desc = "Inside block" },
            },
          },
          move = {
            enable              = true,
            set_jumps           = true,  -- updates jumplist
            goto_next_start     = {
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]c"] = { query = "@class.outer",    desc = "Next class start" },
            },
            goto_next_end       = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]C"] = { query = "@class.outer",    desc = "Next class end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Prev function start" },
              ["[c"] = { query = "@class.outer",    desc = "Prev class start" },
            },
            goto_previous_end   = {
              ["[F"] = { query = "@function.outer", desc = "Prev function end" },
              ["[C"] = { query = "@class.outer",    desc = "Prev class end" },
            },
          },
          swap = {
            enable = true,
            swap_next     = { ["<leader>sa"] = { query = "@parameter.inner", desc = "Swap arg with next" } },
            swap_previous = { ["<leader>sA"] = { query = "@parameter.inner", desc = "Swap arg with prev" } },
          },
        },
      })
    end,
  },
}
