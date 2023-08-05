return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 999,
  opts = {
    style = "moon",
    italic_functions = false,
    terminal_colors = true,
    italic_comments = true,
    italic_keywords = false,
    italic_variables = false,
    transparent = false,
    hide_inactive_statusline = true,
    transparent_sidebar = false,
    dark_sidebar = true,
    dark_float = true,
    lualine_bold = true,
    tokyonight_sidebars = require("common.filetypes").Windows,
    on_colors = function(colors)
      colors.border = "#12131D"
    end,
  },
}
