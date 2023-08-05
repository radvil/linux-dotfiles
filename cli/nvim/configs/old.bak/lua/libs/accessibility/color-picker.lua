---@desc floating color picker
---@type LazySpec
local M = {}
M[1] = "ziontee113/color-picker.nvim"
M.enabled = false
M.cmd = {
  "PickColor",
  "PickColorInsert",
}
local noremap = {
  noremap = true,
  silent = true,
}
M.keys = {
  {
    "<C-c>",
    "<CMD>PickColor<CR>",
    desc = "color-picker » pick",
    unpack(noremap),
  },
  {
    "<C-c>",
    "<CMD>PickColorInsert<CR>",
    desc = "color-picket » pick (imode)",
    unpack(noremap),
    mode = "i",
  },
}
M.config = function()
  require("color-picker").setup()
end
return M
