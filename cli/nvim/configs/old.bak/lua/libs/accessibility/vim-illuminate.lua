---@type LazySpec
local M = {}
M[1] = "RRethy/vim-illuminate"
M.event = "BufReadPost"
M.enabled = true
M.keys = {
  {
    "<A-p>",
    function()
      require("illuminate").goto_prev_reference(false)
    end,
    desc = "Vim Illuminate » Prev ref",
    mode = { "n", "x", "o" },
  },
  {
    "<A-n>",
    function()
      require("illuminate").goto_next_reference(false)
    end,
    desc = "Vim Illuminate » Next ref",
    mode = { "n", "x", "o" },
  },
}
M.opts = {
  delay = 200,
  filetypes_denylist = require("opt.filetype").excludes,
}
M.config = function(_, opts)
  require("illuminate").configure(opts)
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      if require("common.utils").buf_has_keymaps({ "<A-n>", "<A-p>" }) then
        pcall(vim.keymap.del, "n", "<A-n>", { buffer = true })
        pcall(vim.keymap.del, "n", "<A-p>", { buffer = true })
      end
    end,
  })
end
return M
