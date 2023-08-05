---@type LazySpec
local M = {}
M[1] = "tzachar/highlight-undo.nvim"
M.enabled = function()
  return not rnv.opt.minimal_mode
end
M.opts = {
  hlgroup = "HighlightUndo",
  duration = 300,
  keymaps = {
    { "n", "u", "undo", { desc = "Undo" } },
    { "n", "<C-r>", "redo", { desc = "Redo" } },
  },
}
return M
