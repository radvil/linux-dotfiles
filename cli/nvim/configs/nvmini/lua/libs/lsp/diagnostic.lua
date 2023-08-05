local M = {}

M._loaded = false

function M.setup(opts)
  if M._loaded then
    return
  end

  local icons = require("minimal.icon").Diagnostics
  for name, icon in pairs(icons) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, {
      texthl = name,
      text = icon,
      numhl = "",
    })
  end

  if type(opts.virtual_text) == "table" and opts.virtual_text.prefix == "icons" then
    opts.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
      or function(diagnostic)
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end
  end

  vim.diagnostic.config(vim.deepcopy(opts))
  M._loaded = true
end

return M
