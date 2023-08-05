return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    diagnostics = {
      virtual_text = {
        prefix = "icons",
      },
    },
  },

  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    table.insert(keys, { "<c-k>", false, mode = "i" })
  end,
}
