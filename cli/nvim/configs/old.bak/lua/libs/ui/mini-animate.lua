---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.animate"
M.event = "VeryLazy"
M.enabled = function()
  return not vim.g.neovide and rnv.opt.animations and not rnv.opt.minimal_mode
end

M.opts = function()
  -- don't use animate when scrolling with the mouse
  local mouse_scrolled = false
  for _, scroll in ipairs({ "Up", "Down" }) do
    local key = "<ScrollWheel" .. scroll .. ">"
    vim.keymap.set({ "", "i" }, key, function()
      mouse_scrolled = true
      return key
    end, { expr = true })
  end

  local animate = require("mini.animate")
  return {
    cursor = {
      enable = rnv.opt.animate_cursor,
      timing = animate.gen_timing.linear({
        duration = 150,
        unit = "total",
      }),
      -- path = animate.gen_path.line({
      --   predicate = function()
      --     return true
      --   end,
      -- }),
    },
    resize = {
      enable = rnv.opt.animate_window_resize,
      timing = animate.gen_timing.linear({
        duration = 30,
        unit = "total",
      }),
    },
    open = {
      enable = rnv.opt.animate_window_open,
      timing = animate.gen_timing.linear({
        duration = 400,
        unit = "total",
      }),
      winconfig = animate.gen_winconfig.wipe({
        direction = "from_edge",
      }),
      winblend = animate.gen_winblend.linear({
        from = 80,
        to = 100,
      }),
    },
    close = {
      enable = rnv.opt.animate_window_close,
      timing = animate.gen_timing.linear({
        duration = 400,
        unit = "total",
      }),
      winconfig = animate.gen_winconfig.wipe({
        direction = "to_edge",
      }),
      winblend = animate.gen_winblend.linear({
        from = 100,
        to = 80,
      }),
    },
    scroll = {
      enable = rnv.opt.animate_scroll,
      timing = animate.gen_timing.linear({
        duration = 150,
        unit = "total",
      }),
      subscroll = animate.gen_subscroll.equal({
        predicate = function(total_scroll)
          if mouse_scrolled then
            mouse_scrolled = false
            return false
          end
          return total_scroll > 1
        end,
      }),
    },
  }
end

M.config = function(_, opts)
  require("mini.animate").setup(opts)
end

return M
