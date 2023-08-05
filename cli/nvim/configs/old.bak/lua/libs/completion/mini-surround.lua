---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.surround"

M.opts = {
  mappings = {
    add = "so",
    delete = "sd",
    find_left = "s[",
    find = "s]",
    highlight = "sh",
    replace = "ss",
    update_n_lines = "",
  },
}

return M
