return {
  "windwp/nvim-spectre",
  config = true,
  -- stylua: ignore
  keys = {
    {
      "<Leader>sr",
      function() require("spectre").open() end,
      desc = "Spectre » Search & replace",
    },
  },
}
