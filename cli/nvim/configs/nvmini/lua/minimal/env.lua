local opt = {}

opt.dev = false
opt.mapleader = " "
opt.maplocalleader = [[\]]
opt.name = "Nvim Mini"
opt.username = os.getenv("USER")
opt.transbg = not vim.g.neovide
opt.colorscheme = vim.g.neovide and "tokyonight" or "monokai-pro"
opt.colorvariant = opt.colorscheme == "tokyonight" and "moon" or "mocha"
opt.darkmode = true
opt.completion = true
opt.bufferline = false
opt.fold = true
opt.autotag = true
opt.autopairs = true
opt.splitjoin = true
opt.lsp_default_mappings = true
opt.lsp_inlay_hint = false
opt.noice_ux = not vim.g.neovide
opt.float_notification = true
opt.statusline = true
opt.global_statusline = false
opt.inc_rename = not vim.g.neovide
opt.indentblank = true
opt.indentscope = false
opt.whichkey = true
opt.barbeque = true
opt.animations = false
opt.animate_window = false
opt.animate_cursor = false
opt.smooth_cursor = not vim.g.neovide
---@type "neo-tree" | "nvim-tree"
opt.sidebar = "neo-tree"
---@type "dashboard-nvim" | "alpha-nvim"
opt.dashboard = "alpha-nvim"
opt.palette = {
  bg = "#1E1E2E",
  bg2 = "#2F334D",
  fg = "#ffffff",
  fg2 = "#c8d3f5",
  blue = "#3e68d7",
  blue2 = "#51AFEF",
  cyan = "#0DB9D7",
  green = "#6DD390",
  orange = "#FF855A",
  red = "#FF0000",
  red2 = "#EC5F67",
  pink = "#ff007c",
  pink2 = "#E76EB1",
  magenta = "#C678DD",
  violet = "#A9A1E1",
  gold = "#e0af68",
  yellow = "#ffc777",
  yellow2 = "#dbb67d",
}
opt.providers_blacklist = {
  "perl",
  "python3",
  "ruby",
}

_G.minimal = opt
unpack = unpack or table.unpack
