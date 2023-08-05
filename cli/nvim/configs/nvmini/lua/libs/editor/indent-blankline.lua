---@type LazySpec
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  enabled = function()
    return minimal.indentblank
  end,

  opts = {
    char = "│",
    show_current_context = false,
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    char_list = { "│", "»", "┊", "»" },
    filetype_exclude = require("minimal.filetype").Excludes,
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
  },
}
