local M = {}

M.loaded = false

---@param opts PluginLspOpts
function M.setup(opts)
  for name, icon in pairs(opts.icons) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, {
      texthl = name,
      text = icon,
      numhl = "",
    })
  end

  if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
    opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
      or function(diagnostic)
        for d, icon in pairs(opts.icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end
  end

  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

  if opts.inlay_hints.enabled and vim.lsp.buf.inlay_hint then
    require("common.utils").on_attach(function(client, buffer)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(buffer, true)
      end
    end)
  end
end

return M
