local function get_server_options()
  local util = require("lspconfig").util
  local root_files = { "angular.json" }
  local fback_root_files = { "nx.json", "workspace.json" }
  return {
    single_file_support = false,
    capabilities = require("common.lsp").make_client_capabilities(),
    root_dir = function(fname)
      local original = util.root_pattern(unpack(root_files))(fname)
      local fallback = util.root_pattern(unpack(fback_root_files))(fname)
      return original or fallback
    end,
    on_attach = function(client, buffer)
      client.server_capabilities.renameProvider = false
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
      require("common.lsp").attach_keymaps(client, buffer)
    end,
  }
end

---@type LazySpec[]
return {
  {
    "radvil2/nvim-treesitter-angular",
    dependencies = "nvim-treesitter/nvim-treesitter",
    branch = "jsx-parser-fix",
    ft = { "html", "typescript" }
  },
  {
    "neovim/nvim-lspconfig",
    ---@type RvnLspOptions
    opts = {
      servers = { angularls = get_server_options },
    },
  }
}
