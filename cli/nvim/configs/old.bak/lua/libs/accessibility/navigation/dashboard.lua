---@type LazySpec
local M = {}
M[1] = "glepnir/dashboard-nvim"
M.enabled = function()
  return rnv.opt.starter_name == "dashboard"
end
M.event = "VimEnter"

M.opts = {
  theme = "hyper",
  shortcut_type = "number",
  config = {
    disable_move = true,
    week_header = {
      enable = true,
    },
    packages = {
      enable = false,
    },
    mru = {
      enable = true,
      limit = 10,
      icon = "📁 ",
      label = "Most recent used",
    },
    project = {
      enable = false,
      limit = 8,
    },
    shortcut = {
      {
        icon = "📎 ",
        desc = "Plugins",
        group = "@constructor",
        action = [[Lazy]],
        key = "p",
      },
      {
        icon = "🕗 ",
        desc = "Resume",
        group = "DiagnosticWarn",
        action = [[lua require('persistence').load()]],
        key = "s",
      },
      {
        icon = "🔭 ",
        desc = "Files",
        group = "DiagnosticOk",
        action = [[Telescope find_files]],
        key = "f",
      },
      {
        icon = "🔎 ",
        desc = "Grep",
        group = "DiagnosticHint",
        action = [[Telescope live_grep]],
        key = "w",
      },
      {
        icon = "🔧 ",
        desc = "Dotfiles",
        group = "@float",
        action = [[Dotfiles]],
        key = ".",
      },
      {
        icon = "⭕ ",
        desc = "Quit",
        group = "@tag.tsx",
        action = [[qa]],
        key = "q",
      },
    },
  },
}

M.init = function()
  ---@desc close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  ---@desc register telescope dotfiles on VimEnter here
  vim.api.nvim_create_user_command("Dotfiles", function()
    require("common.utils").telescope("files", {
      prompt_title = "🔧 DOTFILES",
      cwd = os.getenv("DOTFILES"),
    })()
  end, { desc = "Telescope » Open dotfiles" })
end

return M
