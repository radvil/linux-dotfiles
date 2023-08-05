return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "typescript",
          "tsx",
        })
      end
    end,
  },

  -- Register code actions
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
      end
    end,
  },

  -- Correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = "jose-elias-alvarez/typescript.nvim",
    ---@type PluginLspOpts
    opts = {
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {
          settings = {
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
      standalone_setups = {
        tsserver = function(_, opts)
          require("minimal.util").on_lsp_attach(function(client, bufnr)
            if client.name == "tsserver" then
              local map = function(lhs, name, desc)
                vim.keymap.set("n", lhs, string.format("<cmd>Typescript%s<cr>", name), {
                  desc = string.format("Typescript » %s", desc),
                  buffer = bufnr,
                })
              end
              map("<leader>cs", "GoToSourceDefinition", "Go to source definition")
              map("<leader>cm", "AddMissingImports", "Add missing imports")
              map("<leader>cc", "RemoveUnused", "Remove unused imports")
              map("<leader>co", "OrganizeImports", "Organize imports")
              map("<leader>cn", "RenameFile", "Rename file")
              map("<leader>ct", "FixAll", "Fix all")
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
