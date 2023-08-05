---@class RnvOptions
local opt = {}
local cond = {
  is_kitty = os.getenv("KITTY_PID") ~= nil,
  is_neovide = vim.g.neovide,
}

opt.name = "RnV"
opt.version = ">= 0.0.1"
opt.dev = false
opt.minimal_mode = not cond.is_neovide
opt.transbg = not vim.g.neovide or false
opt.mapleader = " "
opt.darkmode = true
---@type "neo-tree" | "nvim-tree"
opt.tree = "neo-tree"
opt.whichkey = true
opt.tsrainbow = true
opt.statusline = true
opt.floating_winbar = false
opt.completion = true
opt.maplocalleader = " "
opt.lsp_diagnostics = true
opt.lsp_autoformat = true
opt.lsp_inlay_hint = false
opt.format_notification = false
opt.completion_copilot = false
opt.completion_snippets = true
opt.colorscheme = "tokyonight"
opt.colorvariant = "moon"
opt.animations = true
opt.animate_cursor = true
opt.animate_scroll = false
opt.animate_window_resize = true
opt.animate_window_open = false
opt.animate_window_close = false
opt.data = os.getenv("HOME") .. "/.local/share/nvim/lazy/lazy.nvim"

---@type "dashboard" | "alpha-nvim"
opt.starter_name = "alpha-nvim"
opt.starter_logo = [[
    ██╗     █████╗ ██████╗  █████╗ ██╗   ██╗██╗███╗   ███╗   Z
    ██║    ██╔══██╗██╔══██╗██╔══██╗██║   ██║██║████╗ ████║ Z
    ██║    ███████║██████╔╝███████║██║   ██║██║██╔████╔██║
    ██║    ██╔══██║██╔══██╗██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██████╗██║  ██║██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

opt.palette = {
  bg = "#1A1B23",
  fg = "#ffffff",
  blue = "#51AFEF",
  cyan = "#0DB9D7",
  green = "#6DD390",
  orange = "#FF855A",
  red = "#EC5F67",
  pink = "#E76EB1",
  magenta = "#C678DD",
  violet = "#A9A1E1",
  yellow = "#ECBE7B",
}

---@type LazyConfig
opt.lazy_config = {
  defaults = {
    lazy = false,
    version = nil,
  },
  dev = {
    path = os.getenv("HOME") .. "/Projects/cli-tools",
  },
  checker = {
    enabled = true,
    notify = true,
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  install = {
    colorscheme = {
      "tokyonight",
      "catppuccin",
    },
  },
  performance = {
    reset_packpath = true, -- reset the package path to improve startup time
    cache = { enabled = opt.dev },
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      disabled_plugins = require("opt.filetype").builtin_plugins_excludes,
    },
  },
  ui = {
    border = "rounded",
    title = "Code Nvim",
    title_pos = "center",
    browser = "brave-browser",
    icons = {
      ft = "",
      lazy = "鈴 ",
      loaded = "",
      not_loaded = "",
      cmd = " ",
      config = "",
      event = "",
      init = " ",
      import = " ",
      keys = " ",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = " ",
      list = {
        "",
        "",
        "",
        "‒",
      },
    },
  },
}

return opt
