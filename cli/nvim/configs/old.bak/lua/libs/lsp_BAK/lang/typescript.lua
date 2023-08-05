---@type LazySpec
local M = {}
M[1] = "jose-elias-alvarez/typescript.nvim"
M.event = "BufReadPre"

M.dependencies = {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if opts and type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "tsserver" })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      if opts and type(opts.sources) == "table" then
        vim.list_extend(opts.sources, {
          require("typescript.extensions.null-ls.code-actions"),
        })
      end
    end,
  },
}

local function attach_specific_keymaps(buffer)
  buffer = buffer or 0
  rnv.api.map("n", "gM", ":TypescriptAddMissingImports<CR>", {
    desc = "Typescript » Add missing imports",
    buffer = buffer,
  })
  rnv.api.map("n", "gO", ":TypescriptOrganizeImports<CR>", {
    desc = "Typescript » Organize imports",
    buffer = buffer,
  })
  rnv.api.map("n", "<Leader><f2>", ":TypescriptRenameFile<CR>", {
    buffer = buffer,
    desc = "Typescript » Rename file",
  })
  rnv.api.map("n", "gd", ":TypescriptGoToSourceDefinition<CR>", {
    desc = "Typescript » Go to source",
    buffer = buffer,
  })
  rnv.api.map("n", "gC", ":TypescriptRemoveUnused<cr>", {
    desc = "Typescript » Remove unused imports",
    buffer = buffer,
  })
  rnv.api.map("n", "gF", ":TypescriptFixAll<cr>", {
    desc = "Typescript » Fix all",
    buffer = buffer,
  })
end

M.opts = {
  server = {
    capabilities = require("common.lsp").make_client_capabilities(),
    on_attach = function(client, bufnr)
      require("common.lsp").default_on_attach(client, bufnr)
      attach_specific_keymaps(bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(bufnr, true)
      end
    end,
  },
}

return M
