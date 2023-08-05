local Util = require("minimal.util")
Util.log("Loading keymaps...")

-- reset
Util.map({ "n", "x", "v" }, "<nL>", "<nop>")
Util.map("", "<c-z>", ":undo<cr>", { nowait = true })

-- base
Util.map("v", "<", "<gv", { desc = "Indent left" })
Util.map("v", ">", ">gv", { desc = "Indent right" })
Util.map("n", "U", "<c-r>", { nowait = true, desc = "Redo" })
Util.map("n", "ZZ", ":qa<cr>", { nowait = true, desc = "Quit" })
Util.map("n", "<a-cr>", "o<esc>", { desc = "Add one line down" })
Util.map("i", "<c-d>", "<del>", { desc = "Delete next char" })
Util.map("i", "<c-h>", "<left>", { desc = "Shift one char left" })
Util.map("i", "<c-l>", "<right>", { desc = "Shift one char right" })
Util.map({ "i", "c" }, "<a-bs>", "<esc>ciw", { nowait = true, desc = "Delete backward" })
Util.map({ "i", "c" }, "<a-i>", "<space><esc>i", { desc = "Tab backward" })
Util.map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
Util.map({ "n", "x", "v" }, "ga", "<esc>ggVG", { nowait = true, desc = "Select all" })
Util.map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
Util.map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
Util.map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

if vim.opt.clipboard ~= "unnamedplus" then
  local opt = function(desc)
    return { nowait = true, desc = string.format("System clipboard » %s", desc) }
  end
  Util.map({ "n", "o", "x", "v" }, "gy", '"+y', opt("Yank"))
  Util.map({ "n", "o", "x", "v" }, "gp", '"+p', opt("Paste after cursor"))
  Util.map("n", "gY", '"+y$', opt("Yank line"))
  Util.map("n", "gP", '"+P', opt("Paste before cursor"))
end

-- Clear search, diff update and redraw
Util.map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- swap lines
Util.map("n", "<A-k>", ":m .-2<cr>==", { desc = "Swap current line up" })
Util.map("n", "<A-j>", ":m .+1<cr>==", { desc = "Swap current line down" })
Util.map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "Swap current line down" })
Util.map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "Swap current line up" })
Util.map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Swap selected lines up" })
Util.map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Swap selected lines down" })

-- tabs
Util.map("n", "[t", ":tabprevious<cr>", { desc = "Tab » Prev" })
Util.map("n", "]t", ":tabnext<cr>", { desc = "Tab » Next" })
Util.map("n", "<leader>tn", ":tabnew<cr>", { desc = "Tab » New" })
Util.map("n", "<leader>td", ":tabclose<cr>", { desc = "Tab » Delete" })

-- windows
Util.map("n", "<leader>ww", "<c-w>p", { desc = "Window » Other" })
Util.map("n", "<leader>wd", "<c-w>c", { desc = "Window » Delete" })
if Util.call("smart-splits") == nil then
  Util.map("n", "<c-h>", "<c-w>h", { remap = true, desc = "Window » Navigate left" })
  Util.map("n", "<c-j>", "<c-w>j", { remap = true, desc = "Window » Navigate down" })
  Util.map("n", "<c-k>", "<c-w>k", { remap = true, desc = "Window » Navigate up" })
  Util.map("n", "<c-l>", "<c-w>l", { remap = true, desc = "Window » Navigate right" })
  Util.map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
  Util.map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
  Util.map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
  Util.map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
end

-- buffers
Util.map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
Util.map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
Util.map("n", "[b", ":bprevious<cr>", { desc = "Buffer » Prev" })
Util.map("n", "]b", ":bnext<cr>", { desc = "Buffer » Next" })

if require("minimal.util").call("mini.bufremove") == nil then
  Util.map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
  Util.map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
end

Util.map("n", "<leader>us", function()
  Util.toggle("spell")
end, { desc = "Toggle » Spell" })
Util.map("n", "<leader>uw", function()
  Util.toggle("wrap")
end, { desc = "Toggle » Word wrap" })
Util.map("n", "<leader>uc", function()
  Util.toggle("cursorline")
end, { desc = "Toggle » Cursor line" })
Util.map("n", "<leader>un", function()
  Util.toggle("relativenumber", true)
  Util.toggle("number")
end, { desc = "Toggle » Line numbers" })

---floating terminal
local ft = function(cmd, root)
  local opt = { size = { width = 0.6, height = 0.7 }, title = "  " .. (cmd or "Terminal"), title_pos = "right" }
  opt.border = minimal.transbg and "single" or "none"
  if root then
    opt.cwd = Util.get_root()
  end
  Util.float_term(cmd, opt)
end
Util.map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
Util.map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Float » Terminal hide" })
--stylua: ignore
Util.map("n", "<leader>fh", function() ft("btop") end, { desc = "Float » Open htop/btop" })
--stylua: ignore
Util.map("n", "<leader>fT", function() ft(nil) end, { desc = "Float » Terminal (cwd)" })
--stylua: ignore
Util.map("n", "<leader>ft", function() ft(nil, true) end, { desc = "Float » Terminal (rwd)" })
--stylua: ignore
Util.map("n", [[<c-\>]], function() ft(nil, true) end, { desc = "Float » Terminal open (rwd)" })

if not vim.g.neovide then
  Util.map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "Float » Tmux Z" })
end

---lazygit
local lz = function(opts)
  Util.float_term({ "lazygit" }, {
    unpack(opts or {}),
    title_pos = "right",
    title = "  LazyGit ",
    border = "rounded",
    ctrl_hjkl = false,
    esc_esc = false,
  })
end
--stylua: ignore
Util.map("n", "<leader>gg", function() lz() end, { desc = "Git » Open lazygit (cwd)" })
--stylua: ignore
Util.map("n", "<leader>gG", function() lz({ cwd = Util.get_root() }) end, { desc = "Git » Open lazygit (rwd)" })
