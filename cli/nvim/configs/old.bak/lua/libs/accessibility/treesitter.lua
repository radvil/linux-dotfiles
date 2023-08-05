---@type LazySpec
local M = {}

M[1] = "nvim-treesitter/nvim-treesitter"
M.event = { "BufReadPost", "BufNewFile" }
M.build = ":TSUpdate"
M.keys = {
  {
    "<c-space>",
    desc = "treesitter » increase selection",
    mode = "x",
  },
  {
    "<bs>",
    desc = "treesitter » shrink selection",
    mode = "x",
  },
}

--- @type TSConfig
M.opts = {
  indent = { enable = true },
  highlight = { enable = true },
  ensure_installed = require("opt.filetype").treesitter,
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "<c-space>",
      init_selection = "<c-space>",
      scope_incremental = "<nop>",
      node_decremental = "<bs>",
    },
  },
}

--- @param opts TSConfig
M.config = function(_, opts)
  if type(opts.ensure_installed) == "table" then
    local added = {}
    opts.ensure_installed = vim.tbl_filter(function(lang)
      if added[lang] then
        return false
      end
      added[lang] = true
      return true
    end, opts.ensure_installed)
  end
  require("nvim-treesitter.configs").setup(opts)
end

return M
