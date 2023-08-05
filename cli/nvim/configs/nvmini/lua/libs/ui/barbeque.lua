return {
  "utilyre/barbecue.nvim",
  event = "VeryLazy",
  name = "barbecue",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>ub",
      function()
        local next = not minimal.barbeque
        local lvl = next and vim.log.levels.INFO or vim.log.levels.WARN
        local status = next and "Enabled" or "Disabled"
        minimal.barbeque = next
        require("barbecue.ui").toggle(next)
        vim.notify("Barbeque » " .. status, lvl)
      end,
      desc = "Toggle » Barbeque/Navic",
    },
  },
  opts = function()
    local opts = {
      create_autocmd = false,
      attach_navic = false,
      show_dirname = false,
      show_basename = true,
      show_modified = true,
      context_follow_icon_color = false,
    }
    if minimal.colorscheme == "monokai-pro" then
      opts.theme = "monokai-pro"
    end
    return opts
  end,
  config = function(_, opts)
    require("barbecue").setup(opts)
    vim.api.nvim_create_autocmd({
      "WinScrolled",
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
      "BufModifiedSet",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        if minimal.barbeque then
          require("barbecue.ui").update()
        end
      end,
    })
  end,
}
