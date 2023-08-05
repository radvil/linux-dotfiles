---@type LazySpec
local M = {}
M[1] = "catppuccin/nvim"
M.name = "catppuccin"

M.opts = function()
  return {
    flavour = rnv.opt.colorvariant,
    transparent_background = rnv.opt.transbg,
    term_colors = true,
    dim_inactive = {
      enabled = false,
      percentage = 0.15,
      shade = "dark",
    },
    background = {
      light = "latte",
      dark = "mocha",
    },
    styles = {
      conditionals = { "italic" },
      comments = { "italic" },
    },
    integrations = {
      treesitter = true,
      coc_nvim = false,
      lsp_trouble = true,
      cmp = true,
      lsp_saga = false,
      leap = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      which_key = true,
      dashboard = false,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = true,
      notify = true,
      telekasten = false,
      symbols_outline = true,
      mini = false,
      navic = false,
      noice = false,
      fidget = false,
      neotree = true,
      nvimtree = {
        enabled = false,
        transparent_panel = rnv.opt.transbg,
        show_root = true,
      },
      dap = {
        enabled = false,
        enable_ui = false,
      },
      indent_blankline = {
        enabled = false,
        colored_indent_levels = false,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          information = { "italic" },
          warnings = { "italic" },
          errors = { "italic" },
          hints = { "italic" },
        },
        underlines = {
          information = { "underline" },
          warnings = { "underline" },
          errors = { "underline" },
          hints = { "underline" },
        },
      },
    },
  }
end

M.init = function()
  if rnv.opt.colorscheme == "catppuccin" then
    vim.cmd("colorscheme catppuccin")
  end
end

return M
