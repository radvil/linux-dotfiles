---@type LazySpec
local M = {}
M[1] = "folke/zen-mode.nvim"
M.cmd = "ZenMode"
M.enabled = function()
  return not rnv.opt.minimal_mode
end

M.keys = {
  {
    "<Leader>wz",
    ":ZenMode<cr>",
    desc = "Window » Zen toggle",
  },
}

M.opts = {
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
}

return M
