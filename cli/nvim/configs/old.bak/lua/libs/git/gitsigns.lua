---@type LazySpec
local M = {}
M[1] = "lewis6991/gitsigns.nvim"
M.enabled = true
M.event = "BufReadPre"

---@param bufnr number
---@param lhs string
---@param rhs function | string
---@param desc string
local map = function(bufnr, lhs, rhs, desc)
  return vim.keymap.set("n", lhs, rhs, {
    desc = "Gitsign » " .. desc,
    buffer = bufnr,
  })
end

M.opts = function(_, opts)
  local view_active = false
  local gs = require('gitsigns')
  local util = require("common.utils")

  opts.current_line_blame_opts = {
    delay = 1000,
    virt_text_pos = "right_align",
    virt_text_priority = 100,
  }

  opts.on_attach = function(buffer)
    map(buffer, "<leader>gr", function()
      gs.refresh()
      util.info("View refreshed", { title = "Gitsigns" })
    end, "Refresh view")
    map(buffer, "<leader>gu", function()
      gs.toggle_signs()
      gs.toggle_numhl()
      gs.toggle_linehl()
      gs.toggle_current_line_blame()
      view_active = not view_active
      local lvl = view_active and "info" or "warn"
      local state = view_active and "enabled" or "disabled"
      util[lvl]("View status " .. state, { title = "Gitsigns" })
    end, "Toggle buffer status")
  end
end

return M
