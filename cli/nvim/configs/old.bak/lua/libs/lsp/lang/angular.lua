---@type LazySpec[]
return {
  {
    "radvil2/nvim-treesitter-angular",
    dependencies = "nvim-treesitter/nvim-treesitter",
    branch = "jsx-parser-fix",
    ft = {
      "typescript",
      "html",
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          single_file_support = false,
          root_dir = function(fname)
            local util = require("lspconfig").util
            local original = util.root_pattern("angular.json")(fname)
            local fallback = util.root_pattern("nx.json", "workspace.json")(fname)
            return original or fallback
          end,
        },
      },

      setup = {
        angularls = function()
          require("common.utils").on_attach(function(client)
            if client.name == "angularls" then
              client.server_capabilities.documentRangeFormattingProvider = true
              client.server_capabilities.documentFormattingProvider = true
              client.server_capabilities.renameProvider = false
            end
          end)
        end,
      },
    },
  },
}
