return {
  "RRethy/vim-illuminate",
  event = "BufReadPost",

  opts = {
    filetypes_denylist = require("common.filetypes").Windows,
  },

  -- stylua: ignore
  keys = function()
    return {
      {
        "<A-p>",
        function() require("illuminate").goto_prev_reference(false) end,
        desc = "Vim Illuminate » Prev ref",
        mode = { "n", "x", "o" },
      },
      {
        "<A-n>",
        function() require("illuminate").goto_next_reference(false) end,
        desc = "Vim Illuminate » Next ref",
        mode = { "n", "x", "o" },
      },
    }
  end,

  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        if require("common.utils").buf_has_keymaps({ "<A-n>", "<A-p>" }) then
          pcall(vim.keymap.del, "n", "<A-n>", { buffer = true })
          pcall(vim.keymap.del, "n", "<A-p>", { buffer = true })
        end
      end,
    })
  end,
}
