return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local ic = require("fisher.core.icons")

    -- Shark gradient: deep ocean blue (back) → white (belly)
    -- FISHVIM title mirrors the same gradient top→bottom
    vim.api.nvim_set_hl(0, "AlphaSharkDeep",  { fg = "#1262B8" })          -- deep blue: dorsal/back
    vim.api.nvim_set_hl(0, "AlphaSharkMid",   { fg = "#1E88E5" })          -- royal blue: mid-body
    vim.api.nvim_set_hl(0, "AlphaSharkLight", { fg = "#64B5F6" })          -- sky blue: belly transition
    vim.api.nvim_set_hl(0, "AlphaSharkBelly", { fg = "#BBDEFB" })          -- icy white-blue: belly
    vim.api.nvim_set_hl(0, "AlphaFishVimTop", { fg = "#1E88E5", bold = true }) -- title top: royal blue
    vim.api.nvim_set_hl(0, "AlphaFishVimMid", { fg = "#90CAF9", bold = true }) -- title mid: light blue
    vim.api.nvim_set_hl(0, "AlphaFishVimBot", { fg = "#FFFFFF", bold = true }) -- title bot: pure white
    vim.api.nvim_set_hl(0, "AlphaSubtitle",   { fg = "#42A5F5" })

    dashboard.section.header.val = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣠⣤⣤⠶⠶⠶⠶⠾⠛⠛⠛⠛⠛⠛⠛⢿",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣿⣛⠛⠛⠛⠓⠢⢄⡀⠀⠤⠟⠂⠀⠀⠀⠀⠀⠀⢀⡿",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⠾⠛⠉⠑⠤⣙⢮⡉⠓⣦⣄⡀⠀⣹⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠃",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⣤⡶⠞⠋⠉⠀⠀⠀⠀⠀⠀⠒⠛⠛⠛⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⢰⡟⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠾⠛⠉⣡⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⢺⢿⢉⡽⡟⢓⣶⠦⢤⣀⡀⠈⠳⣿⠁",
      "⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠟⠁⠀⠀⣀⣴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠚⠁⠀⢛⠛⠛⠻⢷⡧⣾⡴⣛⣏⣹⡇⣀⣿ ███████╗██╗███████╗██╗  ██╗██╗   ██╗██╗███╗   ███╗",
      "⠀⠀⠀⠀⠀⠀⣠⠞⠋⠀⣀⠤⠒⢉⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⠋⠀⣀⠴⠚⠛⠛⠯⡑⠂⠀⠀⡏⢹⣿⡾⠟⠋⠁ ██╔════╝██║██╔════╝██║  ██║██║   ██║██║████╗ ████║",
      "⠀⠀⠀⠀⣠⠞⠁⠀⠐⠊⠀⠀⢠⡿⠁⠀⢰⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡏⣤⡿⠋⠀⠀⠀⠀⠀⠀⡹⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⠀█████╗  ██║███████╗███████║██║   ██║██║██╔████╔██║",
      "⠀⠀⣠⡞⠁⠀⠀⠀⠀⠀⠀⢠⡿⠁⢀⢸⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⡞⠋⠉⠉⠓⠒⠢⢤⣴⣥⣆⣠⡾⠋⠀⠀⠀⣦⠀⠀⠀██╔══╝  ██║╚════██║██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "⠀⣼⠋⠀⠀⠀⠀⠀⠀⠀⢀⡟⠀⠀⢸⠀⡆⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⢽⣦⠀⠀⠀⠀⠀⠀⣟⡿⣽⡏⠀⠀⠀⠀⠀⡿⣧⠀⠀██║     ██║███████║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "⢸⣇⣤⣤⣤⣤⣄⡀⠀⢀⡾⠁⠀⠀⢘⡆⠱⡈⢆⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⢻⡚⡆⣀⠀⠀⠀⢸⡽⣿⠃⠀⠀⠀⠀⠀⡇⢹⡄ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "⠀⠀⠀⠀⠀⠀⠈⠙⢷⣾⠃⠀⠀⠀⠈⠾⣦⣙⠪⢷⠄⠀⠀⠀⠀⠀⠀⠀⠈⠻⣭⣟⣹⢦⣀⣀⣟⣹⡟⠀⠀⠀⠀⠀⠀⡇⠈⣷",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⠀⠀⣤⠶⠖⠊⠉⠀⠉⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠦⣼⣞⣹⣯⠟⠁⠀⠀⠀⠀⠀⠀⡇⠀⢹",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⡾⠁⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⣲⡾⠟⠛⠳⣤⡀⠀⠀⠀⠀⠀⠀⡇⠀⣸",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⡟⠁⠀⠀⠀⠀⠀⠀⣼⠇⠀⠀⠀⠀⠀⠀⠀⠙⣻⡿⣿⣯⣁⠀⢰⡀⠀⠀⠙⠳⣄⡀⠀⢠⡟⠋⡔⣿",
      "⠀⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀⠀⢀⡼⠁⠀⠀⠀⠀⠀⠀⠀⢀⠔⠋⢰⠛⢄⠉⠛⠾⣧⡀⠀⠀⠀⠈⠻⣤⣸⡡⠎⢀⡏",
      "⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⠀⢠⡾⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠙⠲⢤⣈⣉⠳⢦⣄⡀⠀⠈⠻⣄⠀⣼⠃",
      "⠀⠀⠀⠀⠀⢀⡟⠀⠀⠀⠀⠀⠀⣠⠟⠀⠙⠢⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠛⠶⣤⡙⣾⠃",
      "⠀⠀⠀⠀⠀⣸⠁⠀⠀⠀⣀⣤⠾⠻⣦⡀⠀⠀⠀⠈⠑⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⠟⠁",
      "⠀⠀⠀⠀⠀⣏⣠⡴⠞⠋⠉⠀⠀⠀⠈⠛⢶⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⣉⣽⠟⠋",
      "⠀⠀⠀⠀⠀⢋⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠒⠶⠶⢤⣤⣤⣤⣤⣤⣤⣤⡤⠴⠶⠖⠚⠋⠉",
      "                                                🐟 H A C K E R ' S  V I M  C H O I C E 🐟",
    }

    -- Per-line gradient: deep blue (top) → white belly (bottom)
    -- FISHVIM title mirrors shark gradient: blue top → white bottom
    -- Mixed line byte splits: where braille ends and ASCII banner begins
    dashboard.section.header.opts = {
      position = "center",
      hl = {
        { { "AlphaSharkDeep",  0, 500 } },                                   -- 1: dorsal/back
        { { "AlphaSharkDeep",  0, 500 } },                                   -- 2
        { { "AlphaSharkDeep",  0, 500 } },                                   -- 3
        { { "AlphaSharkMid",   0, 500 } },                                   -- 4
        { { "AlphaSharkMid",   0, 500 } },                                   -- 5
        { { "AlphaSharkMid",   0, 144 }, { "AlphaFishVimTop", 145, 500 } },  -- 6: mixed
        { { "AlphaSharkMid",   0, 144 }, { "AlphaFishVimTop", 145, 500 } },  -- 7: mixed
        { { "AlphaSharkLight", 0, 166 }, { "AlphaFishVimMid", 167, 500 } },  -- 8: mixed
        { { "AlphaSharkLight", 0, 166 }, { "AlphaFishVimMid", 167, 500 } },  -- 9: mixed
        { { "AlphaSharkBelly", 0, 160 }, { "AlphaFishVimBot", 161, 500 } },  -- 10: mixed
        { { "AlphaSharkBelly", 0, 144 }, { "AlphaFishVimBot", 145, 500 } },  -- 11: mixed (╚═╝ row)
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 12: belly
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 13
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 14
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 15
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 16
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 17
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 18
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 19
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 20
        { { "AlphaSharkBelly", 0, 500 } },                                   -- 21: tail
        { { "AlphaSubtitle",   0, 500 } },                                   -- 22: subtitle
      },
    }

    dashboard.section.buttons.val = {
      dashboard.button("e",       ic.dash.new_file .. " New file",       "<cmd>ene<CR>"),
      dashboard.button("SPC ff",  ic.dash.find     .. " Find files",     "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fs",  ic.dash.grep     .. "Live grep",       "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC fp",  ic.dash.project  .. " Projects",       "<cmd>Telescope project<CR>"),
      dashboard.button("SPC wr",  ic.dash.session  .. " Restore session","<cmd>SessionRestore<CR>"),
      dashboard.button("SPC ee",  ic.dash.explorer .. " File explorer",  "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("m",       ic.dash.mason    .. "Mason",           "<cmd>Mason<CR>"),
      dashboard.button("l",       ic.dash.lazy     .. "Lazy",            "<cmd>Lazy<CR>"),
      dashboard.button("q",       ic.dash.quit     .. " Quit",           "<cmd>qa<CR>"),
    }

    local function footer()
      local stats = require("lazy").stats()
      local date = os.date("%A, %B %d, %Y")
      local plugins = string.format("⚡ %d plugins loaded in %.2fms", stats.count, stats.startuptime)
      return { "", plugins, "📅 " .. date, "Press <Space> to open FishVim command tree" }
    end

    dashboard.section.footer.val = footer()
    dashboard.opts.opts.noautocmd = true

    dashboard.opts.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        pcall(function()
          dashboard.section.footer.val = footer()
          alpha.redraw()
        end)
      end,
    })

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

    local default_cursor = vim.opt.guicursor:get()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt.guicursor = "a:noCursor"
      end,
    })
    vim.api.nvim_create_autocmd("BufUnload", {
      pattern = "<buffer>",
      callback = function()
        vim.opt.guicursor = default_cursor
      end,
    })
  end,
}
