require("config.lazy").bootstrap({
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = {
      colorscheme = "tokyonight",
      defaults = {
        autocmds = true,
        keymaps = false,
      },
    },
  },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "libs.editor" },
  { import = "libs.theme" },
  { import = "libs.misc" },
  { import = "libs.test" },
  { import = "libs.lsp" },
  { import = "libs.ui" },
})
