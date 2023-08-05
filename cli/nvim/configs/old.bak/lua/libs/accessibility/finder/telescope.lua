local M = {}
local util = require("common.utils")
M[1] = "nvim-telescope/telescope.nvim"
M.enabled = true
M.cmd = "Telescope"

M.dependencies = {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
  config = function()
    require("telescope").load_extension("fzf")
  end,
}

M.keys = {
  {
    "<c-p>",
    util.telescope("files"),
    ":Telescope find_files<cr>",
    desc = "telescope » find files",
  },
  {
    "<leader>/d",
    ":Dotfiles<cr>",
    desc = "telescope » find dotfiles",
  },
  {
    "<leader>/f",
    ":Telescope find_files<cr>",
    desc = "telescope » find files (root)",
  },
  {
    "<leader>/w",
    util.telescope("live_grep", { layout_strategy = "vertical" }),
    desc = "telescope » live grep (cwd)",
  },
  {
    "<leader>/W",
    util.telescope("live_grep", { layout_strategy = "vertical", cwd = false }),
    desc = "telescope » live grep (root)",
  },
  {
    "<leader>/S",
    util.telescope("grep_string", { layout_strategy = "vertical" }),
    desc = "telescope » grep string (cwd)",
  },
  {
    "<leader>/s",
    util.telescope("grep_string", { layout_strategy = "vertical", cwd = false }),
    desc = "telescope » grep string (root)",
  },
  {
    "<leader>//",
    ":Telescope resume<cr>",
    desc = "telescope » resume",
  },
  {
    "<leader>/:",
    ":Telescope command_history<cr>",
    desc = "telescope » command history",
  },
  {
    "<leader>/b",
    ":Telescope buffers initial_mode=normal ignore_current_buffer=true sort_mru=true<cr>",
    desc = "telescope » find opened buffers",
  },
  {
    "<leader>/o",
    util.telescope("oldfiles", { cwd = vim.loop.cwd() }),
    desc = "telescope » find recent files (cwd)",
  },
  {
    "<leader>/O",
    ":Telescope oldfiles<cr>",
    desc = "telescope » find recent files (root)",
  },
  {
    "<leader>/h",
    ":Telescope help_tags layout_strategy=vertical<Cr>",
    desc = "telescope » find help tags",
  },
  {
    "<f1>",
    ":Telescope help_tags<cr>",
    desc = "telescope » find help tags",
  },
  {
    "<leader>/H",
    ":Telescope highlights<cr>",
    desc = "telescope » find highlights",
  },
  {
    "<leader>/k",
    ":Telescope keymaps<cr>",
    desc = "telescope » find keymaps",
  },
  {
    "<leader>/M",
    ":Telescope man_pages<cr>",
    desc = "telescope » find man pages",
  },
  {
    "<leader>/C",
    util.telescope("colorscheme", { enable_preview = true }),
    desc = "telescope » find colorscheme",
  },
  {
    "<leader>/c",
    ":Telescope commands<cr>",
    desc = "telescope » find available commands",
  },
  {
    "<leader>/X",
    ":Telescope diagnostics<cr>",
    desc = "telescope » workspace diagnostics",
  },
  {
    "<leader>/x",
    ":Telescope diagnostics bufnr=0<cr>",
    desc = "telescope » find diagnostics (cwd)",
  },
  {
    "<leader>/g",
    ":Telescope git_branches<cr>",
    desc = "telescope » git branches",
  },
  {
    "<leader>/j",
    util.telescope("jumplist", {
      prompt_title = "JUMP LIST",
      initial_mode = "normal",
    }),
    desc = "telescope » jump list",
  },
  {
    "<leader><Tab>",
    util.telescope("oldfiles", {
      prompt_title = "🗒️ RECENT FILES",
      initial_mode = "normal",
      cwd = vim.loop.cwd(),
    }),
    desc = "telescope » most recent used",
  },
}

M.config = function()
  local actions = require("telescope.actions")
  local opts = {
    defaults = {
      layout_config = {
        prompt_position = "top",
        width = 0.9,
      },
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      prompt_prefix = " 🔭 ",
      mappings = {
        ["i"] = {
          ["<a-space>"] = actions.close,
          ["<cr>"] = actions.select_default,
          ["<c-h>"] = actions.select_horizontal,
          ["<c-v>"] = actions.select_vertical,
          ["<c-p>"] = actions.move_selection_previous,
          ["<a-j>"] = actions.cycle_history_next,
          ["<a-k>"] = actions.cycle_history_prev,
          ["<c-n>"] = actions.move_selection_next,
          ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
          ["<c-d>"] = actions.preview_scrolling_down,
          ["<c-u>"] = actions.preview_scrolling_up,
        },
        ["n"] = {
          ["q"] = actions.close,
          ["<esc>"] = actions.close,
          ["<c-p>"] = actions.move_selection_previous,
          ["<c-n>"] = actions.move_selection_next,
          ["<c-h>"] = actions.select_horizontal,
          ["<c-v>"] = actions.select_vertical,
        },
      },
    },
  }
  require("telescope").setup(opts)
end

return M
