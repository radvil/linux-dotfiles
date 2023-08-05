rnv.api.log("Loading vim options...", "opt.options")

vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.foldlevelstart = 99
vim.opt.equalalways = false
vim.opt.smartindent = true
vim.opt.shiftround = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldenable = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.sidescrolloff = 8
vim.opt.undolevels = 100
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.autowrite = true
vim.opt.expandtab = true
vim.opt.timeoutlen = 200
vim.opt.updatetime = 200
vim.opt.winminwidth = 5
vim.opt.undofile = true
vim.opt.foldlevel = 99
vim.opt.laststatus = 3
vim.opt.shiftwidth = 2
vim.opt.pumheight = 10
vim.opt.confirm = true
vim.opt.scrolloff = 9
vim.opt.hidden = true
vim.opt.number = true
vim.opt.cmdheight = 1
vim.opt.winwidth = 7
vim.opt.wrap = false
vim.opt.pumblend = 0
vim.opt.tabstop = 2
vim.opt.list = true
vim.opt.swapfile = false
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.wildmode = "longest:full,full"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.clipboard = "unnamedplus"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.inccommand = "nosplit"
vim.opt.splitkeep = "screen"
vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "1"
vim.opt.mouse = "a"
vim.opt.fillchars = {
  foldopen = require("opt.icons").Folder.ArrowOpened,
  foldclose = require("opt.icons").Folder.ArrowClosed,
  foldsep = " ",
  fold = " ",
  diff = "╱",
  eob = " ",
}
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
}
vim.opt.shortmess:append({
  W = true,
  I = true,
  c = true,
})
vim.opt.spelllang = {
  "en",
  "id",
}

if vim.g.neovide then
  vim.opt.cmdheight = 0
  vim.opt.guifont = { "FiraCode Nerd Font", ":h8" }
  vim.g.neovide_cursor_animate_command_line = false
  ---@type "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
  vim.g.neovide_cursor_vfx_mode = "railgun"
end

vim.g.markdown_recommended_style = 0
