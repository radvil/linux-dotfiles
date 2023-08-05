---@type LazySpec
local M = {}
M[1] = "rebelot/kanagawa.nvim"

M.opts = function()
  return {
    transparent = rnv.opt.transbg, -- do not set background color
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {},
  }
end

M.init = function()
  if rnv.opt.colorscheme == "kanagawa" then
    vim.cmd("colorscheme kanagawa")
  end
end

return M
