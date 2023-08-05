---@type LazySpec
local M = {}
M[1] = "L3MON4D3/LuaSnip"
M.event = "InsertEnter"
M.opts = {
  delete_check_events = "TextChanged",
  history = true,
}
M.keys = {
  {
    "<Tab>",
    function()
      return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
    end,
    expr = true,
    silent = true,
    mode = "i",
  },
  {
    "<Tab>",
    function()
      require("luasnip").jump(1)
    end,
    mode = "s",
  },
  {
    "<S-Tab>",
    function()
      require("luasnip").jump(-1)
    end,
    mode = { "i", "s" },
  },
}
M.config = function()
  local vscode_loader = require("luasnip.loaders.from_vscode")
  vscode_loader.lazy_load()
  vscode_loader.lazy_load({
    paths = {
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
    },
  })
end
return M
