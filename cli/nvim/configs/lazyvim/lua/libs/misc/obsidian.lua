---@param lhs string
---@param rhs string | function
local Kmap = function(lhs, rhs)
  vim.keymap.set("n", lhs, rhs, { silent = true, noremap = false, expr = true })
end

return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/Documents/obsidian-vault/**.md" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    dir = "~/Documents/obsidian-vault",
    finder = "telescope.nvim",
    -- Optional, for templates (see below).
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    open_app_foreground = false,
    -- daily_notes = {
    --   folder = "notes/dailies",
    --   date_format = "%Y-%m-%d",
    -- },
  },
  config = function(_, opts)
    local obs = require("obsidian")
    obs.setup(opts)

    Kmap("gf", function()
      if obs.util.cursor_on_markdown_link() then
        return ":ObsidianFollowLink<cr>"
      else
        return "gf"
      end
    end)
  end,
}
