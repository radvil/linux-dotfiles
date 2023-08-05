return {
  "folke/tokyonight.nvim",
  priority = 999,
  lazy = false,
  opts = function()
    local bgtrans = minimal.transbg
    local darkmode = minimal.darkmode
    local variant = not darkmode and "day" or minimal.colorvariant or "storm"
    local opts = {
      style = variant,
      terminal_colors = true,
      transparent = bgtrans,
      hide_inactive_statusline = true,
      transparent_sidebar = bgtrans,
      dim_inactive = false,
      lualine_bold = true,
      sidebars = require("minimal.filetype").Windows,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      on_colors = function(colors)
        if not minimal.transbg then
          colors.border = "#12131D"
        else
          colors.border = minimal.palette.yellow
        end
      end,
    }

    if bgtrans then
      opts.styles.sidebars = "transparent"
      opts.styles.floats = "transparent"
    end
    return opts
  end,

  init = function()
    if minimal.colorscheme == "tokyonight" then
      vim.cmd.colorscheme("tokyonight")
    end
  end,
}
