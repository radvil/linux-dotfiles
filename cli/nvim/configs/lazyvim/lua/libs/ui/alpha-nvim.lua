return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local db = require("alpha.themes.dashboard")
    local opt = { silent = true }
    db.section.buttons.val = {
      db.button("s", "🕗" .. " Resume session", [[:lua require('persistence').load()<cr>]], opt),
      db.button("r", "📁" .. " Recent files", ":Telescope oldfiles<cr>", opt),
      db.button("f", "🔭" .. " Find files", ":Telescope find_files<cr>", opt),
      db.button("w", "🔎" .. " Search words", ":Telescope live_grep<cr>", opt),
      db.button("n", "📌" .. " Notes", ":TelescopeNotes<cr>", opt),
      db.button("d", "🔧" .. " Config files", ":TelescopeDotfiles<cr>", opt),
      db.button("p", "📎" .. " Manage plugins", ":Lazy<cr>", opt),
      db.button("q", "⭕" .. " Quit session", ":qa<cr>", opt),
    }
    db.opts.layout[1].val = 3
    return db
  end,
}
