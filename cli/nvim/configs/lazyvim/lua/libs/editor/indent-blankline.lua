return {
  {
    "echasnovski/mini.indentscope",
    enabled = false,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("indent_blankline").setup({
        char = "│",
        use_treesitter = false,
        show_current_context = false,
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        char_list = { "│", "»", "┊", "»" },
        filetype_exclude = require("common.filetypes").Excludes,
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
      })
    end,
  },
}
