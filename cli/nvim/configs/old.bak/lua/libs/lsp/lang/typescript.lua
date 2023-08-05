return {
  -- Add typescript to treesitter
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

  -- Register typescriopt linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local code_actions = require("typescript.extensions.null-ls.code-actions")
        table.insert(opts.sources, code_actions)
      end
    end,
  },

  -- Correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = "jose-elias-alvarez/typescript.nvim",
    opts = {
      -- make sure mason installs the server
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
      setup = {
        tsserver = function(_, opts)
          require("common.utils").on_attach(function(client, bufnr)
            if client.name == "tsserver" then
              local map = function(lhs, name, desc)
                rnv.api.map("n", lhs, string.format("<cmd>Typescript%s<cr>", name), {
                  desc = string.format("Typescript » %s", desc),
                  buffer = bufnr,
                })
              end
              map("gd", "GoToSourceDefinition", "Go to source definition")
              map("gM", "AddMissingImports", "Add missing imports")
              map("gC", "RemoveUnused", "Remove unused imports")
              map("gO", "OrganizeImports", "Organize imports")
              map("gR", "RenameFile", "Rename file")
              map("gF", "FixAll", "Fix all")
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
