return {
  {
    "radvil2/nvim-treesitter-angular",
    ft = { "typescript", "html" },
    branch = "jsx-parser-fix",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          if type(opts.ensure_installed) == "table" then
            table.insert(opts.ensure_installed, "scss")
          end
        end,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type PluginLspOpts
    opts = {
      servers = {
        html = {},
        cssls = {},
        angularls = {
          single_file_support = true,
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
          require("lazyvim.util").on_attach(function(client)
            if client.name == "angularls" then
              client.server_capabilities.renameProvider = false
            end
          end)
        end,
      },
    },
  },
}
