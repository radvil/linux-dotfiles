---@type LazySpec
local M = {}
M[1] = "williamboman/mason.nvim"
M.cmd = "Mason"

M.opts = {
  ensure_installed = {
    "markdownlint",
    "shellcheck",
    "eslint_d",
    "prettierd",
    "shfmt",
    "stylua",
  }
}

---@param opts MasonSettings | {ensure_installed: string[]}
M.config = function(_, opts)
  require("mason").setup(opts)
  local mr = require("mason-registry")
  for _, tool in ipairs(opts.ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

return M
