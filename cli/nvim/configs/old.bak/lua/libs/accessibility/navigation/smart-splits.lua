-- or use a specific version
return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    config = function()
      local utils = require("common.utils")
      local o = { title = "Window resize" }
      require("smart-splits").setup({
        -- at_edge = "stop",
        log_level = "info",
        ignored_buftypes = { "terminal" },
        cursor_follows_swapped_bufs = true,
        ignored_filetypes = require("opt.filetype").popups,
        resize_mode = {
          quit_key = "q",
          resize_keys = { "h", "j", "k", "l" },
          silent = true,
          hooks = {
            on_enter = function()
              utils.info("On: press <q> to exit!", o)
            end,
            on_leave = function()
              utils.warn("Off", o)
            end,
          },
        },
        ignored_events = {
          "BufEnter",
          "WinEnter",
        },
      })
    end,
    init = function()
      local ss = require("smart-splits")
      local map = function(lhs, rhs, desc)
        return vim.keymap.set({ "n", "t" }, lhs, rhs, {
          desc = "Window » " .. desc,
          remap = true,
        })
      end
      -- resize keymaps
      map("<c-down>", ss.resize_down, "Resize down")
      map("<c-up>", ss.resize_up, "Resize up")
      map("<c-left>", function() ss.resize_left(6) end, "Resize left")
      map("<c-right>", function() ss.resize_right(6) end, "Resize right")

      -- navigation keymaps
      map("<c-j>", ss.move_cursor_down, "Move cursor down")
      map("<c-k>", ss.move_cursor_up, "Move cursor up")
      map("<c-h>", ss.move_cursor_left, "Move cursor left")
      map("<c-l>", ss.move_cursor_right, "Move cursor right")

      -- swap keymaps
      map("<leader>wj", ss.swap_buf_down, "Swap down")
      map("<leader>wk", ss.swap_buf_up, "Swap up")
      map("<leader>wh", ss.swap_buf_left, "Swap left")
      map("<leader>wl", ss.swap_buf_right, "Swap right")

      -- window operation
      map("<leader>w<cr>", ss.start_resize_mode, "Start resize")
    end,
  },
}
