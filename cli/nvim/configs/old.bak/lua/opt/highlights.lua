---@parm name string
local create_hl = function(name, value)
  name = "Rnv" .. (name:gsub("^%l", string.upper))
  vim.api.nvim_set_hl(0, name, value)
end

for name, hex_color in pairs(rnv.opt.palette) do
  create_hl(name, { fg = hex_color })
end
