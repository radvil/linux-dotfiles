local server_options = {
  settings = {
    gopls = {
      semanticTokens = true,
    },
  },
  on_attach = function(client, buffer)
    -- workaround for gopls not supporting semantictokensprovider
    -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
    require("common.lsp").default_on_attach(client, buffer)
  end
}

---@type LazySpec[]
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "go",
          "gomod",
          "gowork",
          "gosum",
        })
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-go", },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@type RvnLspOptions
    opts = {
      servers = {
        gopls = server_options
      },
    },
  }
}
