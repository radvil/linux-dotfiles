return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",

  keys = {
    {
      "<a-q>",
      ":ZenMode<cr>",
      desc = "Window » Zen toggle",
      silent = true,
    },
    {
      "<Leader>wz",
      ":ZenMode<cr>",
      desc = "Window » Zen toggle",
      silent = true,
    },
  },

  opts = {
    window = {
      backdrop = 0.95,
      width = 120,
      height = 1,
      options = {
        foldcolumn = "0",
      },
    },
    plugins = {
      twilight = {
        enabled = false,
      },
      gitsigns = {
        enabled = true,
      },
      tmux = {
        enabled = false,
      },
      kitty = {
        enabled = false,
        font = "+4",
      },
      alacritty = {
        enabled = false,
        font = "14",
      },
    },
    -- on_open = function()
    --   vim.notify("Window » ZenMode actived")
    -- end,
    -- on_close = function()
    --   vim.notify("Window » Zenmode deactivated", vim.log.levels.WARN)
    -- end,
  },
}
