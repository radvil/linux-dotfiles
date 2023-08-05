return {
  "windwp/nvim-spectre",
  lazy = true,
  --stylua: ignore
  keys = {
    {
      "<Leader>sr",
      function() require("spectre").open() end,
      desc = "Spectre » Search + replace",
    },
  },
}
