return {
  "gen740/SmoothCursor.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ms",
      function()
        minimal.smooth_cursor = not minimal.smooth_cursor
        if minimal.smooth_cursor then
          vim.cmd("SmoothCursorStart")
          vim.notify("Smooth cursor » enabled", vim.log.levels.INFO)
        else
          vim.cmd("SmoothCursorStop")
          vim.notify("Smooth cursor » disabled", vim.log.levels.WARN)
        end
      end,
      desc = "Toggle smooth cursor",
      silent = true,
    },
  },
  opts = {
    disabled_filetypes = require("minimal.filetype").Excludes,
    disable_float_win = true,
    autostart = minimal.smooth_cursor,
    intervals = 13,
    threshold = 1,
    cursor = "",
    type = "exp",
    speed = 13,
    fancy = {
      enable = true,
      head = { cursor = "▷", texthl = "SmoothCursor", linehl = not minimal.transbg and "CursorLine" or nil },
      body = {
        { cursor = "", texthl = "SmoothCursorRed" },
        { cursor = "", texthl = "SmoothCursorOrange" },
        { cursor = "●", texthl = "SmoothCursorYellow" },
        { cursor = "●", texthl = "SmoothCursorGreen" },
        { cursor = "•", texthl = "SmoothCursorAqua" },
        { cursor = ".", texthl = "SmoothCursorBlue" },
        { cursor = ".", texthl = "SmoothCursorPurple" },
      },
      tail = { cursor = nil, texthl = "SmoothCursor" },
    },
  },
}
