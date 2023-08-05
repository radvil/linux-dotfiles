---@type LazySpec
local M = {}
M[1] = "abecodes/tabout.nvim"
M.enabled = true
M.dependencies = { "nvim-cmp", "nvim-treesitter" }
M.opts = {
  tabkey = "<A-l>",
  backwards_tabkey = "<A-h>",
}
return M
