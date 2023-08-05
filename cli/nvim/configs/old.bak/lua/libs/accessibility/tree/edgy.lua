if not rnv.opt.dev then
  return {}
end

---@type LazySpec[]
return {
  ---@type LazySpec
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    keys = {
      {
        [[<leader>\]],
        function()
          require("edgy").toggle()
        end,
        desc = "Edgy » Toggle windows",
      },
      {
        "<leader>wp",
        function()
          require("edgy").select()
        end,
        desc = "Edgy » Pick window",
      },
    },
    opts = {
      options = {
        left = { size = 40 },
        right = { size = 50 },
      },
      animate = {
        enabled = false,
        fps = 100,
        cps = 120,
        on_begin = function()
          vim.g.minianimate_disable = true
        end,
        on_end = function()
          vim.g.minianimate_disable = false
        end,
        spinner = {
          frames = require("opt.icons").SpinnerFrames,
          interval = 80,
        },
      },

      right = {
        {
          ft = "spectre_panel",
          size = { height = 0.5 },
        },
        {
          ft = "Trouble",
          size = { height = 0.5 },
        },
      },

      bottom = {
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.3 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        {
          ft = "qf",
          title = "QuickFix",
        },
        {
          ft = "help",
          size = { height = 20 },
          -- don't open help files in edgy that we're editing
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
      },

      left = {
        {
          title = "  WORKING DIR",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = function()
            vim.api.nvim_input("<esc><space>e")
          end,
          size = { height = 0.7 },
        },
        {
          title = " OPENED BUFFERS",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        -- {
        --   title = " GIT STATUS",
        --   ft = "neo-tree",
        --   filter = function(buf)
        --     return vim.b[buf].neo_tree_source == "git_status"
        --   end,
        --   pinned = true,
        --   open = "Neotree position=right git_status",
        -- },
        "neo-tree",
      },

      -- keys = {
      --   ["<c-Right>"] = function(win)
      --     -- win:resize("width", 2)
      --     require("smart-splits").resize_right()
      --   end,
      --   ["<c-Left>"] = function(win)
      --     -- win:resize("width", -2)
      --     require("smart-splits").resize_left()
      --   end,
      --   ["<c-Up>"] = function(win)
      --     -- win:resize("height", 2)
      --     require("smart-splits").resize_up()
      --   end,
      --   ["<c-Down>"] = function(win)
      --     -- win:resize("height", -2)
      --     require("smart-splits").resize_down()
      --   end,
      -- },
    },
  },

  -- prevent neo-tree from opening files in edgy windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "Trouble", "qf", "Outline" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },

  -- Fix bufferline offsets when edgy is loaded
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require("bufferline.offset")
      if not Offset.edgy then
        local get = Offset.get
        ---@diagnostic disable-next-line: duplicate-set-field
        Offset.get = function()
          if package.loaded.edgy then
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
              local sb = layout[pos]
              if sb and #sb.wins > 0 then
                local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
                ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
                ret[pos .. "_size"] = sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return get()
        end
        Offset.edgy = true
      end
    end,
  },
}
