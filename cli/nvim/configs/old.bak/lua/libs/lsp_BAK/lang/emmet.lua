---@type LazySpec[]
return {
  "neovim/nvim-lspconfig",
  ---@type RvnLspOptions
  opts = {
    servers = {
      emmet_ls = {
        single_file_support = true,
        on_attach = function(client, buffer)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          -- NOTE: test later
          -- require("common.lsp").attach_keymaps(client, buffer)
        end
      }
    },
  },
}
