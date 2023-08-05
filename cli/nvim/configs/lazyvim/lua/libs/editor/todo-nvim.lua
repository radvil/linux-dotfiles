return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "BufReadPost",
  config = true,

  -- stylua: ignore
  keys = function ()
    return {
      {
        "]x",
        function() require("todo-comments").jump_next() end,
        desc = "TODO » Next ref",
        silent = true,
      },
      {
        "[x",
        function() require("todo-comments").jump_prev() end,
        desc = "TODO » Prev ref",
        silent = true,
      },
      {
        "<leader>xt",
        ":TodoTrouble<Cr>",
        desc = "Diagnostics » Todo comments",
        silent = true,
      },
      {
        "<leader>/t",
        ":TodoTelescope<Cr>",
        desc = "Telescope » Find tasks",
        silent = true,
      },
    }
  end,
}
