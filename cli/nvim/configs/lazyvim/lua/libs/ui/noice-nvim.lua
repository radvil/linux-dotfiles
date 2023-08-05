local activated = true

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  enabled = function()
    return not vim.g.neovide
  end,
  -- stylua: ignore
  keys = function ()
    return {
      {
        "<leader>nu",
        function()
          require("noice")[activated and "disable" or "enable"]()
          activated = not activated
          local msg = activated and "Noice UX » enabled" or "Noice UX » Disabled"
          local lvl = activated and vim.log.levels.INFO or vim.log.levels.WARN
          vim.notify(msg, lvl)
        end,
        desc = "Noice » Toggle",
      },
      { "<c-d>", function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end, silent = true, expr = true, desc = "Noice » Scroll forward", mode = {"i", "n", "s"} },
      { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, silent = true, expr = true, desc = "Noice » Scroll backward", mode = {"i", "n", "s"} },
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Noice » Redirect cmdline" },
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice » Last message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice » History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice » All" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Noice » Dismiss All" },
    }
  end,

  opts = function(_, opts)
    ---@type NoiceConfig
    opts = vim.tbl_deep_extend("force", opts or {}, {
      health = { checker = true },
      presets = {
        inc_rename = true,
        long_message_to_split = true,
        command_palette = true,
        bottom_search = true,
        lsp_doc_border = true,
      },
      messages = {
        enabled = true,
        view = "mini",
        view_error = "mini",
        view_warn = "notify",
      },
      lsp = {
        progress = { enabled = false },
        hover = {
          enabled = true,
          silent = true,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        ---message shown by lsp servers
        message = {
          enabled = true,
          view = "mini",
        },
      },
      views = {
        ---display cmdline and popup menu together
        cmdline_popup = {
          position = {
            col = "50%",
            row = 5,
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
        popupmenu = {
          relative = "editor",
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          position = {
            col = "50%",
            row = 8,
          },
          size = {
            width = 60,
            height = 10,
          },
        },
      },
      routes = {
        ---show @recording as notify message
        {
          view = "notify",
          filter = {
            event = "msg_showmode",
          },
        },
        {
          view = "mini",
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
        },
      },
      notify = {
        enabled = true,
        view = "notify",
        opts = {
          replace = true,
          merge = true,
        },
      },
      -- noice tries to move out of the way of existing floating windows.
      smart_move = {
        enabled = false,
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
      },
    })

    ---clean cmdline popup
    ---NOTE: save this for later
    if true then
      ---@type boolean
      opts.presets.lsp_doc_border = false
      opts.views.cmdline_popup.border = {
        style = "none",
        padding = { 1, 2 },
      }
      opts.views.popupmenu.border = {
        style = "none",
        padding = { 1, 2 },
      }
      opts.views.cmdline_popup.win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      }
      opts.views.popupmenu.win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      }
    end

    return opts
  end,
}
