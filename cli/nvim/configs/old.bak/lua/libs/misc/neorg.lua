---@type LazySpec
local M = {}
M[1] = "nvim-neorg/neorg"
M.enabled = false
M.cmd = { "Neorg" }
M.build = ":Neorg sync-parsers"
M.dependencies = "nvim-lua/plenary.nvim"
local function get_vault_path(name)
  return string.format(os.getenv("HOME") .. "/Documents/neorg-vault/%s", name)
end
local function get_workspaces()
  return vim.tbl_extend("force", {
    neovim = get_vault_path("neovim"),
  }, rnv.note_taking.workspaces or {})
end
M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", opts, {
    load = {
      ["core.defaults"] = {},       -- Loads default behaviour
      ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.norg.dirman"] = {      -- Manages Neorg workspaces
        config = {
          workspaces = get_workspaces(),
        },
      },
    },
  })
end
return M
