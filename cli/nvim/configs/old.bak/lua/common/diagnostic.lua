local M = {}

M.loaded = false

M.enabled = rnv.opt.lsp_diagnostics or false

M.opts = {
  update_in_insert = false,
  severity_sort = true,
  underline = true,
  float = {
    border = 'rounded',
    source = 'if_many'
  },
  virtual_text = {
    spacing = 4,
  },
}

local toggle = function()
  M.enabled = not M.enabled
  if M.enabled then
    vim.diagnostic.enable()
    require("common.utils").info("Diagnostics » Enabled", { title = "LSP" })
  else
    vim.diagnostic.disable()
    require("common.utils").warn("Diagnostics » Disabled", { title = "LSP" })
  end
end

M.api = {
  toggle = toggle
}

function M.setup()
  local icons = require("opt.icons")
  if M.loaded then
    rnv.api.log("Diagnostics already loaded!", "common.diagnostics")
    return
  end

  for name, icon in pairs(icons.DiagnosticsFilled) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, {
      texthl = name,
      text = icon,
      numhl = "",
    })
  end

  if vim.fn.has("nvim-0.10.0") == 0 then
    M.opts.virtual_text.prefix = icons.Misc.Squirrel
  else
    M.opts.virtual_text.prefix = function(diagnostic)
      for d, icon in pairs(icons.Diagnostics) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
          return icon
        end
      end
    end
  end

  vim.diagnostic.config(vim.deepcopy(M.opts))

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )

  vim.api.nvim_create_user_command("RnvLspToggleDiagnostics", function()
    M.api.toggle()
  end, {})

  vim.keymap.set("n", "<Leader>ux", M.api.toggle, {
    desc = "Toggle » diagnostics",
  })

  M.loaded = true
end

return M
