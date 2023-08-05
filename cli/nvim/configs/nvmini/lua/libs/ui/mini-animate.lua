---@type LazySpec
return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  enabled = function() return minimal.animations end,
  config = function(_, opts)
    local animate = require("mini.animate")
    opts = vim.tbl_deep_extend("force", opts or {}, {
      cursor = {
        enable = minimal.animate_cursor,
        timing = animate.gen_timing.linear({
          duration = 150,
          unit = 'total'
        }),
        -- path = animate.gen_path.line({
        --   predicate = function()
        --     return true
        --   end,
        -- }),
      },
      resize = {
        enable = minimal.animate_window,
        timing = animate.gen_timing.linear({
          duration = 30,
          unit = "total"
        }),
      },
      open = { enable = false },
      close = { enable = false },
      scroll = { enable = false },
    })
    require("mini.animate").setup(opts)
  end,
}

