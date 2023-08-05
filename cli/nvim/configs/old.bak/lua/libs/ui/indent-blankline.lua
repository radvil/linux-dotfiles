---@desc indentation guide
---@type LazySpec
local M = {}
M[1] = "lukas-reineke/indent-blankline.nvim"
M.enabled = true
M.event = "BufReadPost"
M.opts = {
  -- char = "▏",
  char = "│",
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_current_context = false,
  filetype_exclude = require("opt.filetype").excludes,
  -- default : {'class', 'function', 'method'}
  context_patterns = {
    "class",
    "function",
    "method",
    "^if",
    "^while",
    "^for",
    "^object",
    "^table",
    "^type",
    "^import",
    "block",
    "arguments",
  },
  -- disabled now for performance hit.
  use_treesitter = false,
}

return M
