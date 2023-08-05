local ft = require("common.filetypes")

return {
  {
    "ggandor/leap.nvim",
    enabled = false,
  },
  {
    "ggandor/flit.nvim",
    enabled = function()
      return require("lazy.core.config").plugins["leap"] ~= nil
    end,
  },
  {
    "folke/flash.nvim",
    lazy = true,
    ---@type function
    keys = function()
      return {
        {
          "<a-m>",
          mode = "n",
          function()
            require("flash").jump({
              search = {
                exclude = ft.Popups,
                autojump = false,
                forward = true,
                wrap = true,
              },
            })
          end,
          desc = "Flash » Jump",
        },
        {
          "<a-m>",
          mode = { "x", "o" },
          function()
            require("flash").jump({
              search = {
                multi_window = false,
                forward = true,
                wrap = true,
              },
            })
          end,
          desc = "Flash » Jump",
        },
        {
          "<a-s>",
          mode = { "x", "v" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash » Select node",
        },
        {
          "<a-s>",
          mode = "n",
          function()
            require("flash").treesitter_search({
              search = {
                exclude = ft.Excludes,
              },
            })
          end,
          desc = "Treesitter » Search range",
        },
        {
          "<a-s>",
          function()
            local curr_win = vim.api.nvim_get_current_win()
            local curr_view = vim.fn.winsaveview()
            require("flash").jump({
              action = function(target, state)
                state:hide()
                vim.api.nvim_set_current_win(target.win)
                vim.api.nvim_win_set_cursor(target.win, target.pos)
                require("flash").treesitter({
                  search = {
                    exclude = ft.Excludes,
                  },
                })
                vim.schedule(function()
                  vim.api.nvim_set_current_win(curr_win)
                  vim.fn.winrestview(curr_view)
                end)
              end,
            })
          end,
          mode = "o",
          desc = "Treesitter » Select parent range",
        },
      }
    end,

    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        mode = "exact",
        forward = true,
        multi_window = true,
        incremental = false,
      },
      jump = {
        jumplist = true,
        pos = "start", ---@type "start" | "end" | "range"
        history = false,
        register = false,
        nohlsearch = true,
        autojump = false,
        -- --stylua: ignore
        filetype_exclude = ft.Excludes,
      },
      label = {
        current = true,
        after = false,
        before = true,
        reuse = "lowercase",
      },
      highlight = {
        backdrop = true,
        matches = true,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      modes = {
        search = { enabled = false },
        char = { enabled = false },
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range" },
          backdrop = false,
          matches = false,
          label = {
            before = true,
            after = true,
            style = "inline",
          },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
      },
    },
  },
}
