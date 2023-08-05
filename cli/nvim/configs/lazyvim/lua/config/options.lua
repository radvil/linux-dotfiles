-- options are automatically loaded before lazy.nvim startup
-- default options that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/options.lua

local Icon = require("common.icons")
-- vim.opt.guicursor = ""

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
vim.opt.fillchars = {
  foldopen = Icon.Folder.FoldOpened,
  foldclose = Icon.Folder.FoldClosed,
  diff = Icon.Common.Slash,
  foldsep = " ",
  fold = " ",
  eob = " ",
}

if vim.g.neovide then
  ---@type "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_transparency = 1
  vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h7.5" }
end
