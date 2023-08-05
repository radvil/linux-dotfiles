---@type LazySpec
return {
  "echasnovski/mini.indentscope",
  event = { "BufReadPre", "BufNewFile" },
  enabled = function()
    return minimal.indentscope
  end,

  opts = {
    symbol = "│",
    draw = { delay = 500 },
    mappings = {
      goto_top = "[i",
      goto_bottom = "]i",
      object_scope = "ii",
      object_scope_with_border = "ai",
    },
  },

  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = require("minimal.filetype").Windows,
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
