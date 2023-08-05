return {
  "neovim/nvim-lspconfig",
  dependencies = "jose-elias-alvarez/typescript.nvim",
  ---@type PluginLspOpts
  opts = {
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        keys = {
          { "<leader>ct", "<cmd>TypescriptFixAll<CR>", desc = "Typescript » Try fix all" },
          { "<leader>cn", "<cmd>TypescriptRenameFile<CR>", desc = "Typescript » Rename File" },
          { "<leader>cc", "<cmd>TypescriptRemoveUnused<CR>", desc = "Typescript » Remove unused" },
          { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Typescript » Organize Imports" },
          { "<leader>cm", "<cmd>TypescriptAddMissingImports<CR>", desc = "Typescript » Add missing imports" },
          { "<leader>cs", "<cmd>TypescriptGoToSourceDefinition<CR>", desc = "Typescript » Goto source" },
        },
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
            completeFunctionCalls = false,
          },
        },
      },
    },

    setup = {
      tsserver = function(_, opts)
        require("typescript").setup({ server = opts })
        return true
      end,
    },
  },
}
