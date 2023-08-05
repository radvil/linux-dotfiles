return {
  "williamboman/mason.nvim",
  opts = {},
  keys = function()
    return {
      { "<leader>fm", vim.cmd.Mason, desc = "Float » Mason" },
    }
  end,
}
