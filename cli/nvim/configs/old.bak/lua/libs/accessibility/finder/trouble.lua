---@desc better diagnostics list and others
---@type LazySpec
local M = {}
M[1] = "folke/trouble.nvim"
M.enabled = true
M.cmd = { "TroubleToggle", "Trouble" }
M.opts = { use_diagnostic_signs = true }
M.keys = {
  {
    "<Leader>xd",
    ":TroubleToggle document_diagnostics<cr>",
    desc = "diagnostics » trouble (document)",
  },
  {
    "<Leader>xw",
    ":TroubleToggle workspace_diagnostics<Cr>",
    desc = "diagnostics » trouble (workspace)",
  },
}
return M
