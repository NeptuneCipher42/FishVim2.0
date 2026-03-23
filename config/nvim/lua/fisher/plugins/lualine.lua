return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine     = require("lualine")
    local lazy_status = require("lazy.status")

    -- FishVim cyberpunk color palette (matches tokyonight cyberpunk override)
    local colors = {
      blue        = "#00BFFF",   -- Electric Blue
      cyan        = "#00FFFF",   -- Neon Cyan
      green       = "#39FF14",   -- Neon Green
      yellow      = "#FFD700",   -- Bright Yellow
      magenta     = "#FF00FF",   -- Bright Magenta
      red         = "#FF4A4A",   -- Soft Red for errors
      fg          = "#39FF14",   -- Neon Green text
      bg          = "#000000",   -- Jet Black background
      inactive_bg = "#1A1A1A",  -- Dark Gray for inactive status
    }

    local fishvim_theme = {
      normal   = {
        a = { bg = colors.green,   fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg,      fg = colors.fg },
        c = { bg = colors.bg,      fg = colors.fg },
      },
      insert   = { a = { bg = colors.cyan,    fg = colors.bg, gui = "bold" } },
      visual   = { a = { bg = colors.blue,    fg = colors.bg, gui = "bold" } },
      command  = { a = { bg = colors.magenta, fg = colors.bg, gui = "bold" } },
      replace  = { a = { bg = colors.yellow,  fg = colors.bg, gui = "bold" } },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.fg },
        c = { bg = colors.inactive_bg, fg = colors.fg },
      },
    }

    lualine.setup({
      options = {
        theme             = fishvim_theme,
        icons_enabled     = true,
        -- Nerd Font powerline glyphs (render cleanly in all Nerd Font terminals)
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        globalstatus      = true,
      },

      sections = {
        lualine_a = {
          { "mode", fmt = string.upper },
        },
        lualine_b = {
          { "branch", icon = "" },   -- Nerd Font git branch icon
          { "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            colored = true,
          },
        },
        lualine_c = {
          { "filename", path = 1, icon = "" },   -- relative path + file icon
          {
            "diagnostics",
            sources  = { "nvim_diagnostic" },
            symbols  = { error = " ", warn = " ", info = " ", hint = "󰠠 " },
            colored  = true,
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond  = lazy_status.has_updates,
            color = { fg = colors.yellow },
          },
          { "encoding" },
          {
            "fileformat",
            symbols = { unix = "", dos = "", mac = "" },  -- Nerd Font OS icons
          },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
    })
  end,
}
