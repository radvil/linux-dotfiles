local M = {}

unpack = unpack or table.unpack

function M.setup()
  ---@class RnvSettings
  return {
    opt = require("core.env"),
    api = require("core.api"),
  }
end

---@param params { settings: RnvSettings, on_init: function, after_init: function }
function M.bootstrap(params)
  _G.rnv = params.settings

  local opt = rnv.opt
  local lazyconfig = opt.lazy_config or {}
  local datapath = opt.data or os.getenv("HOME") .. "/.local/share/nvim/lazy/lazy.nvim"

  vim.g.mapleader = opt.mapleader or " "
  vim.g.maplocalleader = opt.maplocalleader or " "

  if not vim.loop.fs_stat(datapath) then
    vim.notify("🚩 lazy.nvim was not installed, installing the latest stable version...")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      datapath,
    })
    rnv.api.log("lazy.nvim installed...", "core")
  end

  vim.opt.rtp:prepend(datapath)
  params.on_init(lazyconfig)
  params.after_init()
end

return M
