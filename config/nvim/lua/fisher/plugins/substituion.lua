-- substitute.nvim: paste-and-replace motions
-- Key conflict fixed: was mapped to `s`/`S` which clashed with flash.nvim.
-- Now uses `cx`/`cxx`/`cX` pattern (common convention, no conflicts).
--   cx<motion>  → replace motion with register content
--   cxx         → replace entire line
--   cX          → replace to end of line
--   cx (visual) → replace visual selection
return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")
    substitute.setup()

    local km = vim.keymap

    -- cx = "change exchange" (classic substitute.nvim convention)
    km.set("n", "cx",  substitute.operator, { desc = "Substitute with motion" })
    km.set("n", "cxx", substitute.line,     { desc = "Substitute entire line" })
    km.set("n", "cX",  substitute.eol,      { desc = "Substitute to end of line" })
    km.set("x", "cx",  substitute.visual,   { desc = "Substitute visual selection" })
  end,
}
