--- @desc: languages linter and formatter
--- @type LazySpec
local M = {}
M[1] = "jose-elias-alvarez/null-ls.nvim"
M.dependencies = { "williamboman/mason.nvim" }
M.event = "BufReadPre"

M.opts = function()
  local nls = require("null-ls")
  return {
    sources = {
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.prettierd,
      nls.builtins.code_actions.eslint_d,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({
            ".eslint.json",
            ".eslintrc",
            ".eslintjs",
          })
        end
      }),
      nls.builtins.formatting.stylua.with({
        condition = function(utils)
          return utils.root_has_file({
            "stylua.toml",
            "luarc.json",
            ".stylua.toml",
            ".luarc",
          })
        end
      }),
    }
  }
end

return M
