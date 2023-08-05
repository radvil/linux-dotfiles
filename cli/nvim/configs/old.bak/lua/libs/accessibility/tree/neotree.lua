---@type LazySpec
local M = {}
M[1] = "nvim-neo-tree/neo-tree.nvim"
M.enabled = function()
  return rnv.opt.tree == "neo-tree"
end
M.dependencies = {
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  "s1n7ax/nvim-window-picker",
}

M.keys = {
  {
    "<leader>e",
    function()
      require("neo-tree.command").execute({
        dir = require("common.utils").get_root(),
        toggle = true,
      })
    end,
    desc = "Neotree » Toggle (root)",
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
  },
  {
    "<leader><cr>",
    ":Neotree buffers<cr>",
    desc = "Neotree » Buffers",
  },
}

M.deactivate = function()
  vim.cmd([[Neotree close]])
end

M.init = function()
  vim.g.neo_tree_remove_legacy_commands = 1

  if vim.fn.argc() == 1 then
    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if stat and stat.type == "directory" then
      require("neo-tree")
    end
  end

  vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*lazygit",
    callback = function()
      if package.loaded["neo-tree.sources.git_status"] then
        require("neo-tree.sources.git_status").refresh()
      end
    end,
  })

  if rnv.api.call("edgy") == nil then
    rnv.api.map("n", [[<leader>\]], function()
      vim.cmd([[Neotree show]])
    end, { desc = "Neotree » Show" })
  end
end

M.opts = function()
  local icons = require("opt.icons")
  local i = function(icon)
    return string.format("%s ", icon)
  end
  return {
    close_if_last_window = true,
    popup_border_style = "rounded",
    use_default_mappings = false,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    event_handlers = {
      {
        id = "RnvNeotreeAfterOpen",
        event = "neo_tree_window_after_open",
        handler = function()
          if rnv.api.call("edgy") == nil then
            rnv.api.map("n", [[<leader>\]], function()
              vim.cmd([[Neotree close]])
            end, { remap = true, desc = "Neotree » Close window" })
          end
        end,
      },
      {
        id = "RnvNeotreeAfterClose",
        event = "neo_tree_window_after_close",
        handler = function()
          if rnv.api.call("edgy") == nil then
            rnv.api.map("n", [[<leader>\]], function()
              vim.cmd([[Neotree show]])
            end, { remap = true, desc = "Neotree » Show window" })
          end
        end,
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
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
    },
    buffers = {
      follow_current_file = true,
      group_empty_dirs = true,
      show_unloaded = true,
    },
    window = {
      width = 40,
      position = "left",
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["l"] = "open",
        ["o"] = "open_with_window_picker",
        ["<cr>"] = "open",
        ["<2-LeftMouse>"] = "open",
        ["<c-v>"] = "open_vsplit",
        ["<c-x>"] = "open_split",

        ["t"] = "open_tabnew",
        ["h"] = "close_node",
        ["za"] = "toggle_node",
        ["zc"] = "close_node",
        ["zC"] = "close_all_nodes",
        ["zO"] = "expand_all_nodes",

        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["<F2>"] = "rename",
        ["c"] = "copy",

        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",

        ["?"] = "show_help",
        ["W"] = "toggle_preview",
        ["w"] = { "toggle_preview", config = { use_float = true } },
        ["<esc>"] = "revert_preview",

        ["R"] = "refresh",
        ["q"] = "close_window",
      },
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ["<c-m>"] = "",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["f"] = "filter_on_submit",
          ["<a-space>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
      },
    },
  }
end

return M
