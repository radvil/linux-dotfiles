-- floating winbar
return {
  "b0o/incline.nvim",
  event = "BufReadPre",
  enabled = function()
    return rnv.opt.floating_winbar and not rnv.opt.minimal_mode
  end,
  config = function()
    local colors = rnv.opt.palette
    require("incline").setup({
      highlight = {
        groups = {
          InclineNormal = {
            guibg = colors.pink,
            guifg = colors.bg,
          },
          InclineNormalNC = {
            guifg = colors.pink,
            guibg = colors.bg,
          },
        },
      },
      window = { margin = { vertical = 0, horizontal = 1 } },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local icon, color = require("nvim-web-devicons").get_icon_color(filename)
        return { { icon, guifg = color }, { " " }, { filename } }
      end,
    })
  end,
}
