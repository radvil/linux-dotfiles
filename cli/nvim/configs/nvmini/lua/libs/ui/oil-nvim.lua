return {
  "stevearc/oil.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  enabled = true,

  -- stylua: ignore
	keys = {
		{
			"<Leader>fe",
			function() require("oil").toggle_float() end,
			desc = "Float » Explorer (pwd)",
      silent = true,
		},
		{
			"<Leader>fE",
			function() require("oil").toggle_float(vim.loop.cwd()) end,
			desc = "Float » Explorer (cwd)",
      silent = true,
		},
	},

  opts = {
    delete_to_trash = true,
    restore_win_options = true,
    trash_command = "trash-put",
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    default_file_explorer = true,
    buf_options = {
      buflisted = true,
      bufhidden = "hide",
    },
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["q"] = "actions.close",
      ["<cr>"] = "actions.select",
      ["^"] = "actions.open_cwd",
      ["H"] = "actions.toggle_hidden",
      ["gx"] = "actions.select_vsplit",
      ["gy"] = "actions.select_split",
      ["-"] = "actions.parent",
      ["K"] = "actions.preview",
      ["<leader>r"] = "actions.refresh",
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
      padding = 2,
      max_width = 96,
      max_height = 45,
      border = minimal.transbg and "single" or "none",
      win_options = { winblend = 0 },
    },
  },

  deactivate = function()
    vim.cmd([[Oil close]])
  end,
}
