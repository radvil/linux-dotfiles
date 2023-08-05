rnv.api.log("Loading keymaps...", "opt.keymaps")

local util = require("common.utils")
local map = rnv.api.map

-- TODO:
-- ' g' `, ← all of these are the same keys to list marks

-- reset
map("i", "<c-d>", "<nop>")
map("n", "<a-cr>", "<nop>")
map("i", "<a-bs>", "<nop>")
map({ "n", "x", "v", "o" }, "-", "$")
map({ "n", "x", "v" }, "<nL>", "<nop>")
map("", "<c-z>", ":undo<cr>", { nowait = true })

-- base
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "U", "<c-r>", { nowait = true, desc = "Redo" })
map("n", "ZZ", ":qa<cr>", { nowait = true, desc = "Quit" })
map("n", "<a-cr>", "o<esc>", { desc = "Add one line down" })
map("i", "<c-d>", "<del>", { desc = "Delete next char" })
map("i", "<c-h>", "<left>", { desc = "Shift one char left" })
map("i", "<c-l>", "<right>", { desc = "Shift one char right" })
map({ "i", "c" }, "<a-bs>", "<esc>ciw", { nowait = true, desc = "Delete one word left" })
map({ "i", "c" }, "<a-i>", "<space><esc>i", { desc = "Delete one word right" })
map("n", "<leader>xl", ":lopen<cr>", { desc = "Diagnostics » Open in loclist" })
map("n", "<leader>xe", ":copen<cr>", { desc = "Diagnostics » Open in quickfix" })
map("n", "<c-g>", "ggVG", { desc = "Select all content" })
map("v", "<c-g>", "<esc>", { desc = "Unselect all content" })
map("i", "<c-g>", "<esc>ggVG", { desc = "Select all content" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
-- map({ "n", "x", "v" }, "K", "5k", { desc = "Shift 5 top" })
-- map({ "n", "x", "v" }, "J", "5j", { desc = "Shift 5 down" })
map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
map({ "n", "x", "v" }, "+", ":join<cr>", { nowait = true, desc = "Join lines" })
map({ "n", "x", "v" }, "q", "<esc>", { nowait = true, desc = "Escape to normal" })
-- map({ "n", "x", "v" }, ";", ":", { nowait = true, silent = false, desc = "Drop into cmdline" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Clear search, diff update and redraw
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

if vim.opt.clipboard ~= "unnamedplus" then
  local opt = function(desc)
    return { remap = true, nowait = true, desc = string.format("System clipboard %s » ", desc) }
  end
  map({ "n", "o", "x", "v" }, "gy", '"+y', opt("Copy"))
  map({ "n", "o", "x", "v" }, "gp", '"+p', opt("Paste before cursor"))
  map("n", "gY", '"+y$', opt("Copy line"))
  map("n", "gP", '"+P', opt("Paste after cursor"))
end

-- move to window using the <ctrl> hjkl keys
if not os.getenv("TMUX") then
  map("n", "<c-h>", "<c-w>h", { remap = true, desc = "Window » Navigate left" })
  map("n", "<c-j>", "<c-w>j", { remap = true, desc = "Window » Navigate down" })
  map("n", "<c-k>", "<c-w>k", { remap = true, desc = "Window » Navigate up" })
  map("n", "<c-l>", "<c-w>l", { remap = true, desc = "Window » Navigate right" })
end

-- swap lines
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Swap current line up" })
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Swap current line down" })
map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "Swap current line down" })
map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "Swap current line up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Swap selected lines up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Swap selected lines down" })

-- tabs
map("n", "[t", ":tabprevious<cr>", { desc = "Tab » Prev" })
map("n", "]t", ":tabnext<cr>", { desc = "Tab » Next" })
map("n", "<leader>tn", ":tabnew<cr>", { desc = "Tab » New" })
map("n", "<leader>td", ":tabclose<cr>", { desc = "Tab » Delete" })

-- windows
map("n", "<leader>ww", "<c-w>p", { desc = "Window » Other" })
map("n", "<leader>wd", "<c-w>c", { desc = "Window » Delete" }) -- TODO: same as <Cmd>close ??
if rnv.api.call("smart-splits") == nil then
  map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
  map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
  map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
  map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
end

-- buffers
map("n", "<Leader>`", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
map("n", "<Leader>bb", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
map("n", "[b", ":bprevious<cr>", { desc = "Buffer » Prev" })
map("n", "]b", ":bnext<cr>", { desc = "Buffer » Next" })
if rnv.api.call("mini.bufremove") == nil then
  map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
  map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
end

map("n", "<leader>uw", function()
  util.toggle("wrap")
end, { desc = "Toggle » Word wrap" })
map("n", "<leader>us", function()
  util.toggle("spell")
end, { desc = "Toggle » Word spell" })
map("n", "<leader>uc", function()
  util.toggle("cursorline")
end, { desc = "Toggle » Cursor line" })
map("n", "<leader>un", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "Toggle » Line numbers" })

if vim.lsp.buf.inlay_hint then
  map("n", "<leader>uh", function()
    vim.lsp.buf.inlay_hint(0, nil)
  end, {
    desc = "Toggle » Inlay hint",
  })
end

if rnv.api.call("edgy") ~= nil then
  map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Escape terminal" })
  map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
  map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
  map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
  map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
end

---floating terminal
---@param cmd string | nil
---@param root boolean
local ft = function(cmd, root)
  local opt = { size = { width = 0.6, height = 0.7 }, title = "  " .. (cmd or "Terminal"), title_pos = "right" }
  if not rnv.opt.transbg then
    opt.border = "none"
  end
  if root then
    opt.cwd = util.get_root()
  end
  util.float_term(cmd, opt)
end
map("n", [[<c-\>]], function()
  ft(nil, true)
end, { desc = "Float » Terminal open (root dir)" })
map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Float » Terminal hide" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
map("n", "<leader>ft", function()
  ft(nil, true)
end, { desc = "Float » Terminal (root dir)" })
map("n", "<leader>fT", function()
  ft(nil)
end, { desc = "Float » Terminal (curr dir)" })
map("n", "<leader>fh", function()
  ft("htop")
end, { desc = "Float » Open htop" })
map("n", "<leader>fn", function()
  ft("node")
end, { desc = "Float » NodeJS" })
map("n", "<leader>mw", function()
  vim.cmd([[call system('ami-project')]])
end, { desc = "Tmux » Switch ami workspace" })
map("n", "<leader>mm", function()
  vim.cmd([[call system('zmux')]])
end, { desc = "Tmux » Switch to most recent" })

---floating lazygit
---@param opts LazyCmdOptions
local lz = function(opts)
  util.float_term({ "lazygit" }, {
    unpack(opts or {}),
    title_pos = "right",
    title = "  LazyGit ",
    border = "rounded",
    ctrl_hjkl = false,
    esc_esc = false,
  })
end
map("n", "<leader>gG", function()
  lz({ cwd = util.get_root() })
end, { desc = "Git » Open lazygit (root dir)" })
map("n", "<leader>gg", function()
  lz()
end, { desc = "Git » Open lazygit (curr dir)" })
