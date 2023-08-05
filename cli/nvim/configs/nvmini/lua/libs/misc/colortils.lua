return {
  "max397574/colortils.nvim",
  cmd = "Colortils",
  keys = {
    {
      "<leader>mc",
      ":Colortils picker<cr>",
      desc = "Color picker",
      silent = true,
    },
  },
  config = function()
    require("colortils").setup()
  end,
}
