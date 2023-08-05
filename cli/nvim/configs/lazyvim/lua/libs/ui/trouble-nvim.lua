local open_with_trouble = function(...)
  require("trouble.providers.telescope").open_with_trouble(...)
end

local open_selected_with_trouble = function(...)
  require("trouble.providers.telescope").open_selected_with_trouble(...)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        mappings = {
          ["n"] = {
            ["<a-x>"] = open_with_trouble,
            ["<a-t>"] = open_selected_with_trouble,
          },
          ["i"] = {
            ["<a-x>"] = open_with_trouble,
            ["<a-t>"] = open_selected_with_trouble,
          },
        },
      },
    },
  },

  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    ---@type function
    keys = function()
      return {
        {
          "<Leader>xd",
          ":TroubleToggle document_diagnostics<cr>",
          desc = "Diagnostics » Trouble (doc lvl)",
        },
        {
          "<Leader>xw",
          ":TroubleToggle workspace_diagnostics<Cr>",
          desc = "Diagnostics » Trouble (cwd lvl)",
        },
      }
    end,
  },
}
