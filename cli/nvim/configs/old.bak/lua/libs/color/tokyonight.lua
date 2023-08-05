---@type LazySpec
local M = {}
M[1] = "folke/tokyonight.nvim"

M.opts = function()
  local bgtrans = rnv.opt.transbg
  local darkmode = rnv.opt.darkmode
  local variant = not darkmode and "day" or rnv.opt.colorvariant or "storm"

  local opts = {
    style = variant,
    terminal_colors = true,
    transparent = bgtrans,
    hide_inactive_statusline = true,
    transparent_sidebar = bgtrans,
    day_brightness = 0.3,
    lualine_bold = true,
    dim_inactive = false,
    sidebars = require("opt.filetype").sidebars,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = "NONE",
      variables = "NONE",
      sidebars = "dark",
      floats = "dark",
    },
    on_colors = function(colors)
      colors.diff.delete = "#ff0000"
      colors.border = "#12131D"
    end,
    on_highlights = function(hl)
      hl.CursorLine.bold = true
    end,
  }
  if bgtrans then
    opts.styles.sidebars = "transparent"
    opts.styles.floats = "transparent"
    opts.dim_inactive = false
  end
  return opts
end

M.init = function()
  if rnv.opt.colorscheme == "tokyonight" then
    vim.cmd("colorscheme tokyonight")
  end
end

return M
