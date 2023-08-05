---@type LazySpec
local M = {}
M[1] = "goolord/alpha-nvim"
M.enabled = rnv.opt.starter_name == "alpha-nvim"
M.event = "VimEnter"

M.opts = function()
  local db = require("alpha.themes.dashboard")
  local logo = rnv.opt.starter_logo
  db.section.header.val = vim.split(logo, "\n")
  db.section.buttons.val = {
    db.button("s", "🕗" .. " Resume session", [[:lua require('persistence').load()<cr>]]),
    db.button("o", "📁" .. " Recent files", ":Telescope oldfiles<cr>"),
    db.button("f", "🔭" .. " Find files", ":Telescope find_files<cr>"),
    db.button("w", "🔎" .. " Search words", ":Telescope live_grep<cr>"),
    db.button("t", "📌" .. " List all tasks", ":TodoTelescope<cr>"),
    db.button("d", "🔧" .. " Config files", ":Dotfiles<cr>"),
    db.button("p", "📎" .. " Manage plugins", ":Lazy<cr>"),
    db.button("q", "⭕" .. " Quit session", ":qa<cr>"),
  }
  for _, button in ipairs(db.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
  end
  db.section.header.opts.hl = "AlphaHeader"
  db.section.buttons.opts.hl = "AlphaButtons"
  db.section.footer.opts.hl = "AlphaFooter"
  db.opts.layout[1].val = rnv.opt.minimal_mode and 3 or 8
  return db
end

M.init = function()
  vim.api.nvim_create_user_command("Dotfiles", function()
    require("common.utils").telescope("files", {
      prompt_title = "🔧 DOTFILES",
      cwd = os.getenv("DOTFILES"),
    })()
  end, { desc = "Telescope » Open dotfiles" })
end

M.config = function(_, db)
  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end
  require("alpha").setup(db.opts)
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      db.section.footer.val = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

return M
