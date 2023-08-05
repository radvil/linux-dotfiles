local core = require("minimal")

core.bootstrap(function(opts)
  require("minimal.option")

  require("lazy").setup({
    require("lazy"),
    require("libs.color"),
    require("libs.editor"),
    require("libs.misc"),
    require("libs.lsp"),
    require("libs.ui"),
  }, opts)

  vim.schedule(function()
    require("minimal.autocmd")
    require("minimal.keymap")
  end)
end)
