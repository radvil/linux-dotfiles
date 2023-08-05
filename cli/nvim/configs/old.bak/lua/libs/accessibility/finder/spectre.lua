---@type LazySpec
local M = {}
M[1] = "windwp/nvim-spectre"
M.enabled = true
M.keys = {
  {
    "<Leader>sr",
    function()
      require("spectre").open()
    end,
    desc = "spectre » search & replace",
  },
}
return M
