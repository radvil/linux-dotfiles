---@type LazySpec
local M = {}

M[1] = "catppuccin/nvim"
M.name = "catppuccin"
M.priority = 1000
M.lazy = false

M.config = function()
  require("catppuccin").setup({
    ---@type string
    flavour = vim.g.neovide and "macchiato" or minimal.colorvariant,
    transparent_background = minimal.transbg,
    term_colors = true,
    dim_inactive = {
      enabled = vim.g.neovide or not minimal.transbg,
      percentage = 0.13,
      shade = "dark",
    },
    integrations = {
      alpha = true,
      barbecue = {
        dim_dirname = true,
        bold_basename = false,
        dim_context = true,
        alt_background = true,
      },
      treesitter = true,
      dropbar = false,
      lsp_trouble = true,
      cmp = true,
      gitsigns = true,
      which_key = true,
      markdown = true,
      ts_rainbow2 = false,
      notify = true,
      mini = true,
      noice = true,
      neotree = true,
      nvimtree = false,
      harpoon = true,
      mason = true,
      illuminate = true,
      navic = {
        enabled = true,
        custom_bg = "lualine",
      },
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      native_lsp = {
        enabled = true,
        inlay_hints = {
          background = true,
        },
      },
      telescope = {
        enabled = true,
        style = "nvchad",
      },
    },
    custom_highlights = function()
      return {
        FlashCurrent = {
          fg = minimal.palette.bg,
          bg = minimal.palette.yellow,
          style = { "bold" },
        },
        FlashMatch = {
          fg = minimal.palette.bg2,
          bg = minimal.palette.blue2,
        },
        FlashLabel = {
          fg = minimal.palette.fg,
          bg = minimal.palette.pink,
          style = { "bold" },
        },
        NeoTreeIndentMarker = {
          fg = "#313244",
        },
      }
    end,
  })
end

M.init = function()
  if minimal.colorscheme == "catppuccin" then
    vim.cmd.colorscheme("catppuccin")
  end
end

return M
