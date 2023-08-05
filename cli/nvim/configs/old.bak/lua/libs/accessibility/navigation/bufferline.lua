---@desc tabline/bufferline/etc
---@type LazySpec
local M = {}
M[1] = "akinsho/nvim-bufferline.lua"
M.enabled = true
M.event = "VeryLazy"
M.dependencies = { "nvim-tree/nvim-web-devicons" }
M.keys = function()
  local Kmap = function(lhs, cmd, desc)
    cmd = string.format("<cmd>BufferLine%s<cr>", cmd)
    desc = string.format("Buffer » %s", desc)
    return { lhs, cmd, desc = desc, silent = true }
  end
  return {
    Kmap("<a-b>", "Pick", "Pick"),
    Kmap("<leader>bS", "SortByTabs", "Sort by tabs"),
    Kmap("<leader>bs", "SortByDirectory", "Sort by directory"),
    Kmap("<leader>bp", "TogglePin", "Toggle pin"),
    Kmap("<a-.>", "MoveNext", "Shift right"),
    Kmap("<a-,>", "MovePrev", "Shift left"),
    Kmap("<a-[>", "CyclePrev", "Switch prev"),
    Kmap("<a-]>", "CycleNext", "Switch next"),
    Kmap("<a-1>", "GoToBuffer 1", "Switch 1st"),
    Kmap("<a-2>", "GoToBuffer 2", "Switch 2nd"),
    Kmap("<a-3>", "GoToBuffer 3", "Switch 3rd"),
    Kmap("<a-4>", "GoToBuffer 4", "Switch 4th"),
    Kmap("<a-5>", "GoToBuffer 5", "Switch 5th"),
    Kmap("<leader>bB", "CloseLeft", "Close left"),
    Kmap("<leader>bW", "CloseRight", "Close right"),
    Kmap("<leader>bC", "CloseOthers", "Close others"),
  }
end
M.opts = {
  options = {
    diagnostics = "nvim_lsp",
    sort_by = "insert_at_end",
    --- @type "thin" | "padded_slant" | "slant" | "thick" | "none"
    separator_style = "thin",
    indicator = {
      ---@type "icon" | "underline" | "none"
      style = "icon",
    },
    show_close_icon = false,
    show_tab_indicators = true,
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      local icons = require("opt.icons").Diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = require("opt.icons").Misc.Vim .. " Tree View",
        highlight = "BufferLineBackground",
        text_align = "left",
        separator = false,
      },
      {
        filetype = "neo-tree",
        text = require("opt.icons").Misc.Vim .. " SIDENAV VIEW",
        highlight = "BufferLineBackground",
        text_align = "left",
        separator = false,
      },
    },
  },
}
return M
