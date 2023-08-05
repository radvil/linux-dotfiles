---@type LazySpec
-- stylua: ignore
local M = {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>nd",
      function() require("notify").dismiss({ pending = true, silent = true }) end,
      desc = "Notification » Dismiss",
    },
  },

  opts = function(_, opts)
    opts.max_height = function() return math.floor(vim.o.lines * 0.75) end
    opts.max_width = function() return math.floor(vim.o.columns * 0.36) end
    opts.replace = true
    opts.timeout = 1000
    return opts
  end,
}

return M
