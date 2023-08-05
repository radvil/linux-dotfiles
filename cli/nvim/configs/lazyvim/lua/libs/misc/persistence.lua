---@type LazySpec
local M = {}
M[1] = "folke/persistence.nvim"
M.event = "BufReadPre"
M.opts = {
  options = {
    --"folds",
    "buffers",
    "tabpages",
    "winsize",
    "skiprtp",
    "globals",
    "curdir",
    "help",
  },
}

return M
