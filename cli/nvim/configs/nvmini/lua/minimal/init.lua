local M = {}

local function get_default_opts()
  local icon = require("minimal.icon").Common
  local title = string.format(" %s %s ", icon.Vim, minimal.name)
  return {
    -- directory where plugins will be installed
    root = vim.fn.stdpath("data") .. "/" .. minimal.username,
    defaults = {
      lazy = not minimal.dev,
    },
    ui = {
      size = { width = 0.8, height = 0.8 },
      wrap = true,
      border = minimal.transbg and "single" or "",
      title = title,
      title_pos = "right",
      icons = {
        cmd = icon.CmdOutlined,
        config = icon.Cog,
        event = icon.Flash,
        ft = icon.File,
        init = icon.Start,
        import = icon.Import,
        keys = icon.Keys,
        lazy = icon.Lazy,
        loaded = icon.Bullet,
        not_loaded = icon.BulletOutlined,
        plugin = icon.Package,
        runtime = icon.Vim,
        source = icon.Source,
        start = icon.Check,
        task = icon.Calendar,
        list = {
          icon.Bullet,
          icon.ArrowRight,
          icon.Star,
          "‒",
        },
      },
    },
    install = {
      missing = true,
      colorscheme = {
        "tokyonight",
        "catppuccin",
      },
    },
    performance = {
      cache = { enabled = not minimal.dev },
      rtp = {
        disabled_plugins = require("minimal.filetype").Builtins,
      },
    },
  }
end

function M.bootstrap(on_init)
  require("minimal.env")

  vim.g.mapleader = minimal.mapleader
  vim.g.maplocalleader = minimal.maplocalleader

  for _, value in ipairs(minimal.providers_blacklist) do
    vim.cmd(string.format("let g:loaded_%s_provider = 0", value))
  end

  local util = require("minimal.util")
  local opts = get_default_opts()
  local userpath = string.format("/%s/lazy.nvim", minimal.username)
  local path = vim.fn.stdpath("data") .. userpath

  if not vim.loop.fs_stat(path) then
    util.log("🚩 lazy.nvim was not installed. Installing from latest stable version...", {
      severity = vim.log.levels.WARN,
      title = "BOOTSRAP",
    })

    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      path,
    })
  end

  vim.opt.rtp:prepend(path)
  on_init(opts)
end

return M
