---@type LazySpec
local M = {}
M[1] = "stevearc/oil.nvim"
M.dependencies = "nvim-tree/nvim-web-devicons"
M.enabled = true

M.keys = {
  -- {
  --   "<Leader>fo",
  --   function()
  --     require("oil").open()
  --   end,
  --   desc = "Oil Nvim » Open Parent Dir"
  -- },
  {
    "<Leader>fe",
    function()
      require("oil").toggle_float()
    end,
    desc = "Float » Explorer (pwd)",
  },
}

M.opts = {
  default_file_explorer = false,
  restore_win_options = true,
  skip_confirm_for_simple_edits = false,
  delete_to_trash = true,
  trash_command = "trash-put",
  prompt_save_on_select_new_entry = true,
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = "actions.show_help",
    ["q"] = "actions.close",
    ["<cr>"] = "actions.select",
    ["<bs>"] = "actions.parent",
    ["^"] = "actions.open_cwd",
    ["gh"] = "actions.toggle_hidden",
    ["gx"] = "actions.select_vsplit",
    ["gy"] = "actions.select_split",
    ["gp"] = "actions.preview",
    ["gr"] = "actions.refresh",
    -- ["<C-t>"] = "actions.select_tab",
    -- ["`"] = "actions.cd",
    -- ["~"] = "actions.tcd",
  },
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "n",
  },
  float = {
    padding = 10,
    max_width = 96,
    max_height = 45,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  -- floating preview window
  preview = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.7,
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
}

M.deactivate = function()
  vim.cmd([[Oil close]])
end

return M
