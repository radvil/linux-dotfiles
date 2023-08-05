---@type LazySpec[]
return {
  "neovim/nvim-lspconfig",
  ---@type PluginLspOpts
  opts = {
    servers = {
      emmet_ls = {
        cmd = { "emmet-ls", "--stdio" },
        filetypes = { "html", "css", "scss" },
        root_dir = function()
          return vim.loop.cwd()
        end,
        settings = {
          single_file_support = true,
        },
      },
    },
  },
}
