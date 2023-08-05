---@type LazySpec
local M = {}
M[1] = "folke/todo-comments.nvim"
M.enabled = true
M.event = "BufReadPost"
M.cmd = { "TodoTrouble", "TodoTelescope" }
M.config = true
M.keys = {
  {
    "]]",
    function()
      require("todo-comments").jump_next()
    end,
    desc = "todo-comment » next ref",
    remap = true,
  },
  {
    "[[",
    function()
      require("todo-comments").jump_prev()
    end,
    desc = "todo-comment » prev ref",
    remap = true,
  },
  {
    "<Leader>xt",
    ":TodoTrouble<Cr>",
    desc = "diagnostics » todo comments",
  },
  {
    "<Leader>/t",
    ":TodoTelescope<Cr>",
    desc = "telescope » find todo comments",
  },
}
return M
