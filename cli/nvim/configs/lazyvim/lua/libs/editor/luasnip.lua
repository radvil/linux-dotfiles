return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    local vscode_loader = require("luasnip.loaders.from_vscode")
    vscode_loader.lazy_load()
    -- TODO: adjust snippets to be available to all nvim variants
    vscode_loader.lazy_load({
      paths = {
        os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
        os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
      },
    })
  end,
}
