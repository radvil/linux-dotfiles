---@type LazySpec[]
return {
  {
    "ggandor/leap.nvim",
    --stylua: ignore
    enabled = false,
    keys = {
      {
        "<a-m>",
        function()
          require("leap").leap({
            target_windows = {
              vim.fn.win_getid(),
            },
          })
        end,
        desc = "Leap » Visual selection (continue)",
        mode = { "x", "o" },
      },
      {
        "<a-m>",
        function()
          require("leap").leap({
            target_windows = vim.tbl_filter(function(win)
              return vim.api.nvim_win_get_config(win).focusable
            end, vim.api.nvim_tabpage_list_wins(0)),
          })
        end,
        desc = "Leap » Accross all windows",
        mode = "n",
      },
    },

    config = function()
      local leap = require("leap")
      leap.opts.case_sensitive = false
      -- NOTE: IDK why I need these
      leap.opts.special_keys = {
        repeat_search = "<enter>",
        next_phase_one_target = "<enter>",
        next_target = { "<enter>", ";" },
        prev_target = { "<tab>", "," },
        multi_revert = "<backspace>",
        multi_accept = "<enter>",
        next_group = "<space>",
        prev_group = "<tab>",
      }
      leap.opts.labels = {
        "s",
        "f",
        "n",
        "j",
        "k",
        "l",
        "h",
        "o",
        "d",
        "w",
        "e",
        "m",
        "b",
        "u",
        "y",
        "v",
        "r",
        "g",
        "t",
        "c",
        "x",
        "/",
        "z",
        "S",
        "F",
        "N",
        "J",
        "K",
        "L",
        "H",
        "O",
        "D",
        "W",
        "E",
        "M",
        "B",
        "U",
        "Y",
        "V",
        "R",
        "G",
        "T",
        "C",
        "X",
        "?",
        "Z",
      }
    end,
  }, -- EOL leap.nvim

  {
    "ggandor/flit.nvim",
    --stylua: ignore
    enabled = false,
    dependencies = "ggandor/leap.nvim",

    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({
        "f",
        "F",
        "t",
        "T",
      }) do
        ret[#ret + 1] = {
          key,
          mode = {
            "n",
            "x",
            "o",
          },
          desc = key,
        }
      end
      return ret
    end,

    opts = {
      labeled_modes = "nox",
      multiline = false,
      keys = {
        f = "f",
        F = "F",
        t = "t",
        T = "T",
      },
    },
  },
}
