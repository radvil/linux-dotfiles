---@desc undo history
---@type LazySpec
local M = {}
M[1] = "mbbill/undotree"
M.enabled = false
M.keys = {
  {
    "<leader>U",
    ":UndotreeToggle<cr>",
    desc = "undotree » toggle",
  },
}
return M
