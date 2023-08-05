local function hello()
  local name = minimal.username:gsub("^%l", string.upper)
  local time = os.date("*t")
  local hour = time.hour
  local messages = {
    "󰒲  Go sleep!",
    "  Good morning",
    "  Good afternoon",
    "  Good evening",
    "󰖔  Good night",
  }
  local idx
  -- stylua: ignore
  if hour == 23 or hour < 4 then idx = 1
  elseif hour < 12 then idx = 2
  elseif hour >= 12 and hour < 18 then idx = 3
  elseif hour >= 18 and hour < 21 then idx = 4
  elseif hour >= 21 then idx = 5
  end
  return os.date(" %Y-%m-%d »  %H:%M") .. " » " .. messages[idx] .. " " .. name
end

---@type LazySpec
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = function()
    return minimal.dashboard == "alpha-nvim"
  end,

  opts = function()
    local db = require("alpha.themes.dashboard")
    --     local logo = [[
    --  ███╗   ██╗██╗   ██╗███╗   ███╗██╗███╗   ██╗██╗
    --  ████╗  ██║██║   ██║████╗ ████║██║████╗  ██║██║
    --  ██╔██╗ ██║██║   ██║██╔████╔██║██║██╔██╗ ██║██║
    --  ██║╚██╗██║╚██╗ ██╔╝██║╚██╔╝██║██║██║╚██╗██║██║
    --  ██║ ╚████║ ╚████╔╝ ██║ ╚═╝ ██║██║██║ ╚████║██║
    --  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝
    -- ]]
    -- db.section.header.val = vim.split(logo .. "\n" .. hello(), "\n")
    local logo = [[
MMMMMMMMMMMMMMMMM.                             MMMMMMMMMMMMMMMMMM
 `MMMMMMMMMMMMMMMM           M\  /M           MMMMMMMMMMMMMMMM'
   `MMMMMMMMMMMMMMM          MMMMMM          MMMMMMMMMMMMMMM'
     MMMMMMMMMMMMMMM-_______MMMMMMMM_______-MMMMMMMMMMMMMMM
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
     .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.
               `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'
                      `MMMMMMMMMMMMMMMMMM'
                          `MMMMMMMMMM'
                             MMMMMM 
                              MMMM
                               MM
]]
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
    db.opts.layout[1].val = 3
    return db
  end,

  config = function(_, db)
    require("alpha").setup(db.opts)

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

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        db.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " libs in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
