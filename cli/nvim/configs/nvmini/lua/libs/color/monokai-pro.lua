return {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 999,
  opts = function()
    local opts = {
      ---@type "classic" | "octagon" | "pro" | "machine" | "ristretto" | "spectrum"
      filter = "octagon",
      inc_search = "background",
      terminal_colors = true,
      devicons = true,
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
          underline_fill = false,
          bold = false,
        },
        indent_blankline = {
          context_highlight = "pro",
          context_start_underline = false,
        },
      },
      override = function()
        return {
          LazyNormal = { link = "Normal" },
          LspInlayHint = { link = "Comment" },
          ZenBg = { bg = minimal.palette.bg },
          Visual = {
            bg = "#55435b",
          },
          TelescopeSelectionCaret = {
            link = "Visual",
          },
          TelescopeMatching = {
            fg = minimal.palette.yellow,
          },
          FlashCurrent = {
            fg = minimal.palette.bg,
            bg = minimal.palette.yellow,
            bold = true,
          },
          FlashMatch = {
            fg = minimal.palette.bg2,
            bg = minimal.palette.blue2,
          },
          FlashLabel = {
            fg = minimal.palette.fg,
            bg = minimal.palette.pink,
            bold = true,
          },
        }
      end,
    }

    if minimal.transbg then
      opts.transparent_background = true
      opts.background_clear = {
        "toggleterm",
        "float_win",
        "telescope",
        "which-key",
        "telescope",
        "neo-tree",
        "renamer",
        "notify",
        "mason",
        "cmp_menu",
        "lsp_info",
        "noice",
      }
    end

    return opts
  end,

  init = function()
    if minimal.colorscheme == "monokai-pro" then
      vim.cmd.colorscheme("monokai-pro")
    end
  end,
}
