---@type LazySpec
local M = {}
M[1] = "rcarriga/nvim-notify"
M.event = "BufReadPost"
M.enabled = function()
  return true or not rnv.opt.minimal_mode
end

M.opts = function(_, opts)
  if rnv.opt.transbg then
    opts.background_colour = "#000000"
  end
  if rnv.opt.dev then
    opts.timeout = 10000
  else
    opts.timeout = 1000
    opts.max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end
    opts.max_width = function()
      return math.floor(vim.o.columns * 0.36)
    end
  end
  return opts
end

M.init = function()
  vim.notify = require("notify")
end

M.keys = {
  {
    "<leader>uN", -- TODO: Toggle notification
    function()
      require("notify").dismiss({
        silent = true,
        pending = true,
      })
    end,
    desc = "Notification » Dismiss",
  },
}

return M
