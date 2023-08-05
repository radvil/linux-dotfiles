return {
  "akinsho/bufferline.nvim",

  config = function(_, opts)
    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      show_close_icon = false,
      show_tab_indicators = true,
      always_show_bufferline = false,
      indicator = { style = "icon" },
      diagnostics = "nvim_lsp",
      separator_style = "thin",
      hover = {
        enabled = true,
        reveal = { "close" },
        delay = 200,
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = " ~ TREE VIEW",
          highlight = "BufferLineBackground",
          text_align = "left",
          separator = false,
        },
      },
    })

    require("bufferline").setup(opts)
  end,

  opts = function(_, opts)
    if vim.cmd.colorscheme == "catppuccin" then
      opts.options.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end
    return opts
  end,

  keys = function()
    local Kmap = function(lhs, cmd, desc)
      cmd = string.format("<cmd>BufferLine%s<cr>", cmd)
      desc = string.format("Buffer » %s", desc)
      return { lhs, cmd, desc = desc, silent = true }
    end
    return {
      Kmap("<a-b>", "Pick", "Pick"),
      Kmap("<leader>bS", "SortByTabs", "Sort by tabs"),
      Kmap("<leader>bs", "SortByDirectory", "Sort by directory"),
      Kmap("<leader>bp", "TogglePin", "Toggle pin"),
      Kmap("<a-.>", "MoveNext", "Shift right"),
      Kmap("<a-,>", "MovePrev", "Shift left"),
      Kmap("<a-[>", "CyclePrev", "Switch prev"),
      Kmap("<a-]>", "CycleNext", "Switch next"),
      Kmap("<a-1>", "GoToBuffer 1", "Switch 1st"),
      Kmap("<a-2>", "GoToBuffer 2", "Switch 2nd"),
      Kmap("<a-3>", "GoToBuffer 3", "Switch 3rd"),
      Kmap("<a-4>", "GoToBuffer 4", "Switch 4th"),
      Kmap("<a-5>", "GoToBuffer 5", "Switch 5th"),
      Kmap("<leader>bB", "CloseLeft", "Close left"),
      Kmap("<leader>bW", "CloseRight", "Close right"),
      Kmap("<leader>bC", "CloseOthers", "Close others"),
    }
  end,
}
