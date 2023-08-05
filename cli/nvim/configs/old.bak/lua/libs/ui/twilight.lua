---@desc dim mode
---@type LazySpec
local M = {}
M.event = "BufReadPre"
M[1] = "folke/twilight.nvim"
M.enabled = function()
  return not rnv.opt.minimal_mode
end
M.cmd = { "Twilight", "TwilghtEnable", "TwilightDisable" }
---@type TwilightOptions
M.opts = {
  treesitter = true,
  context = 10,
  dimming = {
    alpha = 0.25,
    color = { "Normal", "#ffffff" },
    term_bg = "#000000",
    inactive = true, -- dimm incative windows
  },
  expand = {
    "if_statement",
    "function",
    "method",
    "table",
  },
  exclude = require("opt.filetype").excludes,
}
return M
