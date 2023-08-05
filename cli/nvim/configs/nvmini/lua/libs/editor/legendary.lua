return {
  "mrjones2014/legendary.nvim",
  lazy = false,
  priority = 9999,
  keys = {
    {
      "<leader>q",
      ":Legendary<cr>",
      desc = "Quick Command/Keymaps Palette",
      silent = true,
    },
  },
  config = function()
    require("legendary").setup({
      select_prompt = " Quick command/keymaps ",
      include_legendary_cmds = false,
      include_builtin = true,
      lazy_nvim = {
        auto_register = true,
      },
      which_key = {
        auto_register = true,
      },
      extensions = {
        diffview = true,
        smart_splits = true,
      },
    })
  end,
}
