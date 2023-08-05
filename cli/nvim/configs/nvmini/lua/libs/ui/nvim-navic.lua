return {
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    require("minimal.util").on_lsp_attach(function(client, buffer)
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = function()
    return {
      separator = " » ",
      highlight = true,
      depth_limit = 5,
      icons = require("minimal.icon").KindIcons,
    }
  end,
}
