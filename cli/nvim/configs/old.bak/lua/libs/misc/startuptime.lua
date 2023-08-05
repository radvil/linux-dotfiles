---@type LazySpec
local M = {}
M[1] = "dstein64/vim-startuptime"
M.cmd = "StartupTime"
M.config = function()
  vim.g.startuptime_tries = 10
end
return M
