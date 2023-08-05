---@type LazySpec
local M = {}
M[1] = "neovim/nvim-lspconfig"
M.event = { "BufReadPre", "BufNewFile" }
M.enabled = true

M.dependencies = {
  "mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = true,
  },
  {
    "folke/neodev.nvim",
    opts = {
      experimental = {
        pathStrict = true,
      },
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    cond = function()
      return require("common.utils").has("nvim-cmp")
    end,
  },
}

---@class RvnLspOptions
M.opts = {
  install_missing_servers = true,
  ---NOTE: set value to false to prevent autoinstall servers
  servers = {
    ["jsonls"] = true,
    ["bashls"] = true,
    ["html"] = {},
    ["cssls"] = {},
    ["lua_ls"] = {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            workspaceWord = true,
            callSnippet = "Replace",
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
        },
      },
    },
    ["tsserver"] = {
      root_dir = function(...)
        return require("lspconfig.util").root_pattern(".git")(...)
      end,
      single_file_support = false,
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
}

local function get_defaults()
  return {
    capabilities = require("common.lsp").make_client_capabilities(),
    on_attach = require("common.lsp").default_on_attach,
  }
end

---@param options RvnLspOptions
local setup_language_servers = function(options)
  local ensure_installed = {}
  ---@param opts function | table | boolean
  for server, opts in pairs(options.servers) do
    if type(opts) == "boolean" and opts == false then
      opts = get_defaults()
    else
      ensure_installed[#ensure_installed + 1] = server
      if type(opts) == "function" then
        opts = opts() or get_defaults()
      elseif type(opts) == "table" then
        opts = vim.tbl_deep_extend("force", get_defaults(), opts or {})
      else
        opts = get_defaults()
      end
    end
    require("lspconfig")[server].setup(opts)
  end

  require("lspconfig.ui.windows").default_options.border = "single"
  require("mason-lspconfig").setup({
    automatic_installation = options.install_missing_servers,
    ensure_installed = ensure_installed,
  })
end

---@param opts RvnLspOptions
M.config = function(_, opts)
  require("common.lsp").register_user_cmds()
  require("common.diagnostic").setup()
  require("common.formatter").setup()
  setup_language_servers(opts)
end

return M
