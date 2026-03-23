return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug continue" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug terminate" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open debug REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed = { "debugpy", "codelldb", "js" },
        automatic_installation = true,
      })

      require("nvim-dap-virtual-text").setup()
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      local ok_py, dap_python = pcall(require, "dap-python")
      if ok_py then
        dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
      end
    end,
  },
}
