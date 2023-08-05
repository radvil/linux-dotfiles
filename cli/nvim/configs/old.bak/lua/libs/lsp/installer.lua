-- Cmdline tools and lsp servers
return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = {
    {
      "<leader>fm",
      "<cmd>Mason<cr>",
      desc = "LSP » Installer",
    },
  },
  opts = {
    ensure_installed = {
      "prettierd",
      "stylua",
      "shfmt",
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require("mason").setup(opts)
    local registry = require("mason-registry")
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = registry.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if registry.refresh then
      registry.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
