return {
  "radvil2/windows.nvim",
  dependencies = "anuvyklack/middleclass",
  event = "VeryLazy",

  keys = {
    {
      "<Leader>wm",
      ":WindowsMaximize<cr>",
      desc = "Window » Maximize/minimize",
      silent = true,
    },
    {
      "<Leader>w=",
      ":WindowsEqualize<cr>",
      desc = "Window » Equalize",
      silent = true,
    },
    {
      "<Leader>wu",
      ":WindowsToggleAutowidth<cr>",
      desc = "Window » Toggle autowidth",
      silent = true,
    },
  },

  config = function()
    require("windows").setup({
      animation = { enable = false, },
      autowidth = {
        enable = false,
        winwidth = 5,
        filetype = {
          help = 2,
        },
      },
      ignore = {
        buftype = { "nofile", "quickfix", "edgy" },
        filetype = {
          unpack(require("minimal.filetype").Popups),
          "help"
        }
      }
    })
  end,
}
