return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gowork",
        "gomod",
        "gosum",
        "go",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              semanticTokens = true,
              staticcheck = true,
              gofumpt = true,
              codelenses = {
                upgrade_dependency = true,
                run_govulncheck = true,
                regenerate_cgo = true,
                gc_details = false,
                generate = true,
                vendor = true,
                test = true,
                tidy = true,
              },
              hints = {
                functionTypeParameters = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                assignVariableTypes = true,
                rangeVariableTypes = true,
                constantValues = true,
                parameterNames = true,
              },
              analyses = {
                fieldalignment = true,
                unusedparams = true,
                unusedwrite = true,
                nilness = true,
                useany = true,
              },
              directoryFilters = {
                "-node_modules",
                "-.vscode-test",
                "-.vscode",
                "-.idea",
                "-.git",
              },
            },
          },
        },
      },
      setup = {
        gopls = function()
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          require("common.utils").on_attach(function(client, _)
            if client.name == "gopls" then
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  range = true,
                  full = true,
                  legend = {
                    tokenModifiers = semantic.tokenModifiers,
                    tokenTypes = semantic.tokenTypes,
                  },
                }
              end
            end
          end)
        end,
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local nls = require("null-ls")
        vim.list_extend(opts.sources, {
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,
          nls.builtins.formatting.gofumpt,
          nls.builtins.formatting.goimports_reviser,
        })
      end
    end,
  },
}
