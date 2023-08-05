-- stylua: ignore
if minimal.sidebar ~= "neo-tree" then return {} end

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "s1n7ax/nvim-window-picker" },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,

  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({
          dir = require("minimal.util").get_root(),
          toggle = true,
        })
      end,
      desc = "Neotree » Toggle (root)",
      silent = true,
    },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({
          dir = vim.loop.cwd(),
          toggle = true,
        })
      end,
      desc = "Neotree » Toggle",
      silent = true,
    },
    {
      "<leader><cr>",
      ":Neotree buffers<cr>",
      desc = "Neotree » Buffers",
      silent = true,
    },
  },

  config = function(_, opts)
    local icons = require("minimal.icon")
    local i = function(icon)
      return string.format("%s ", icon)
    end
    opts.default_component_configs = {
      indent = {
        with_markers = true,
        with_expanders = false,
        -- indent_marker = "┊",
        expander_collapsed = icons.Folder.FoldClosed,
        expander_expanded = icons.Folder.FoldOpened,
      },
      git_status = {
        symbols = {
          -- Change type
          added = i(icons.Git.AddedFilled),
          deleted = i(icons.Git.DeletedFilled),
          modified = i(icons.Git.Modified),
          renamed = i(icons.Git.Renamed),
          -- Status type
          staged = i(icons.Git.StagedFilled),
          unstaged = i(icons.Git.UnstagedFilled),
          untracked = i(icons.Git.Untracked),
          conflict = i(icons.Git.Conflict),
          ignored = i(icons.Git.Ignored),
        },
      },
    }
    opts.window = {
      width = 40,
      position = "left",
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["l"] = "open",
        ["w"] = "open_with_window_picker",
        ["<cr>"] = "open",
        ["<2-LeftMouse>"] = "open",
        ["<c-v>"] = "open_vsplit",
        ["<c-x>"] = "open_split",
        ["<c-t>"] = "open_tabnew",

        ["h"] = "close_node",
        ["za"] = "toggle_node",
        ["zc"] = "close_node",
        ["zM"] = "close_all_nodes",
        ["zR"] = "expand_all_nodes",

        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["<F2>"] = "rename",
        ["c"] = "copy",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",

        ["?"] = "show_help",
        ["K"] = { "toggle_preview", config = { use_float = true } },
        ["<esc>"] = "revert_preview",
        ["R"] = "refresh",
      },
    }

    opts.filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "disabled",
      window = {
        mappings = {
          ["."] = "set_root",
          ["/"] = "fuzzy_finder",
          ["H"] = "toggle_hidden",
          ["<bs>"] = "navigate_up",
          ["f"] = "filter_on_submit",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["<a-space>"] = "clear_filter",
        },
      },
    }

    opts.source_selector = {
      winbar = true,
      statusline = false,
      truncation_character = "…",
      show_scrolled_off_parent_node = true,
      highlight_tab = "BufferLineBackground",
      highlight_separator = "BufferLineBackground",
      highlight_background = "BufferLineBackground",
      highlight_tab_active = "BufferLineBufferSelected",
      highlight_separator_active = "BufferLineIndicatorSelected",
      sources = {
        {
          source = "filesystem",
          display_name = " 󰙅 files",
        },
        {
          source = "buffers",
          display_name = "  buffers",
        },
        {
          source = "git_status",
          display_name = "  git",
        },
      },
    }

    require("neo-tree").setup(opts)

    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}
