---@type LazySpec
local M = {}
M[1] = "sindrets/diffview.nvim"
M.cmd = {
  "DiffviewOpen",
  "DiffviewClose",
  "DiffviewToggleFiles",
  "DiffviewFocusFiles"
}

M.keys = {
  {
    "<leader>gd",
    ":DiffviewOpen<cr>",
    desc = "Git » Open diff view"
  },
  {
    "<leader>gh",
    ":DiffviewOpen<cr>",
    desc = "Git » Open file history"
  }
}

M.opts = {
  hooks = {
    diff_buf_read = function(_)
      vim.opt_local.wrap = false
      vim.opt_local.list = false
      vim.opt_local.colorcolumn = { 80 }
    end,
    view_opened = function(view)
      local msg = "%s » Opened on tabpage %d"
      require("common.utils").info(msg:format(view.class:name(), view.tabpage))
    end,
    view_closed = function(view)
      local msg = "%s » Closed on tabpage %d"
      require("common.utils").warn(msg:format(view.class:name(), view.tabpage))
    end,
  }
}

return M
