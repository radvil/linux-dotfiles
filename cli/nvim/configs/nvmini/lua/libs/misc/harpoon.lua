return {
  "ThePrimeagen/harpoon",
  -- stylua: ignore
  keys = {
    {
      "<leader>mf",
      function()
        require("harpoon.mark").add_file()
        vim.notify("Marked", vim.log.levels.INFO, {
          title = "Harpoon",
          icon = "📌",
        })
      end,
      desc = "Mark file",
    },
    {
      [[<leader>\]],
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "Marked file list",
    },
    { "[f",
      function() require("harpoon.ui").nav_prev() end,
      desc = "Prev marked file",
    },
    {
      "]f",
      function() require("harpoon.ui").nav_next() end,
      desc = "Next marked file",
    },
  },

  opts = {
    mark_branch = false,
    save_on_change = false,
    save_on_toggle = false,
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = vim.list_extend(
      vim.deepcopy(require("minimal.filetype").Popups),
      require("minimal.filetype").Windows
    ),
    menu = {
      width = vim.api.nvim_win_get_width(0) - 13,
    },
  },
}
