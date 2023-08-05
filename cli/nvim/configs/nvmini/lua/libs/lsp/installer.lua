local icon = require("minimal.icon").Common

return {
  "williamboman/mason.nvim",
  cmd = "Mason",

  keys = {
    {
      "<leader>fm",
      vim.cmd.Mason,
      desc = "Float » Mason",
    },
  },

  opts = {
    ui = {
      border = minimal.transbg and "single" or "none",
      icons = {
        package_uninstalled = icon.Lens,
        package_installed = icon.Flash,
        package_pending = icon.Start,
      },
    },
    ensure_installed = {
      "stylua",
      "shfmt",
    },
  },

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
