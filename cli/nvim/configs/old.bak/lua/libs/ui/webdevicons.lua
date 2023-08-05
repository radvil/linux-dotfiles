---@type LazySpec
local M = {}
M[1] = "nvim-tree/nvim-web-devicons"
M.lazy = false
M.opts = {
  override = require("opt.icons").api.get_webdevicons(),
  default = true,
}
return M
