---@type LazySpec
local M = {}
M[1] = "s1n7ax/nvim-window-picker"
M.event = "VeryLazy"
M.config = function()
  local util = require("common.utils")
  local picker = require("window-picker")
  local filetypes = {
    unpack(require("opt.filetype").popups),
    "neo-tree",
  }
  picker.setup({
    hint = "floating-big-letter",
    show_prompt = false,
    prompt_message = "Window » Pick",
    other_win_hl_color = rnv.opt.palette.yellow,
    filter_rules = {
      autoselect_one = true,
      include_current = false,
      bo = {
        buftype = { "terminal" },
        filetype = filetypes,
      },
    },
  })

  -- stylua: ignore
  local pick_window = function()
    local win = picker.pick_window({ include_current_win = false })
    if not win then win = vim.api.nvim_get_current_win() end
    vim.api.nvim_set_current_win(win)
  end

  -- stylua: ignore
  local swap_window = function()
    local curr_win = vim.api.nvim_get_current_win()
    local target_win = picker.pick_window({ include_current_win = false })
    if not target_win then target_win = curr_win end
    local target_ft = vim.api.nvim_get_option_value("filetype", { win = target_win })
    local target_buf = vim.fn.winbufnr(target_win)
    if util.list_has(filetypes, target_ft) then
      util.warn("Not possible!", {
        title = "Window picker",
      })
      return
    end
    vim.api.nvim_win_set_buf(target_win, 0)
    vim.api.nvim_win_set_buf(0, target_buf)
    vim.api.nvim_set_current_win(target_win)
  end

  --stylua: ignore
  local map = function(lhs, rhs, desc)
    rnv.api.map("n", lhs, rhs, {
      desc = string.format(
        "Window » %s",
        desc
      )
    })
  end

  map("<a-w>", pick_window, "Select using picker")
  map("<leader>ws", swap_window, "Swap using picker")
end

return M
