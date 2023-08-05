---@type LazySpec
local M = {}
M[1] = "simrat39/symbols-outline.nvim"
M.event = "VeryLazy"
M.enabled = function()
  return not rnv.opt.minimal_mode
end

M.opts = {
  highlight_hovered_item = true,
  relative_width = false,
  auto_close = false,
  position = "right",
  keymaps = {
    close = { "<esc>", "q" },
    goto_location = { "<cr>", "o" },
    focus_location = "l",
    hover_symbol = "K",
    toggle_preview = nil,
    rename_symbol = "gr",
    code_actions = "ga",
    fold = "zc",
    unfold = "zo",
    fold_all = "zC",
    unfold_all = "zO",
    fold_reset = "zU",
  },
  width = 40,
  wrap = false,
  show_guides = true,
  auto_preview = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = false,
  preview_bg_highlight = "Pmenu",
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { "", "" },
  lsp_blacklist = {},
  symbol_blacklist = {},
}

M.keys = {
  {
    "<leader>uS",
    ":SymbolsOutline<cr>",
    desc = "Toggle » Symbols outline",
  },
}

return M
