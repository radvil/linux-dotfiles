-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
local LazyUtil = require("lazyvim.util")
local Util = require("common.utils")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = LazyUtil.has("noice") or vim.opt.cmdheight == 0 or opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- reset
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
map({ "i", "c" }, "<a-bs>", "<esc>ciw", { nowait = true, desc = "Delete backward" })
map({ "i", "c" }, "<a-i>", "<space><esc>i", { desc = "Tab backward" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
map({ "n", "x", "v" }, "ga", "<esc>ggVG", { nowait = true, desc = "Select all" })
map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

if vim.opt.clipboard ~= "unnamedplus" then
  local opt = function(desc)
    return { remap = true, nowait = true, desc = string.format("System clipboard » %s", desc) }
  end
  map({ "n", "o", "x", "v" }, "gy", '"+y', opt("Yank"))
  map({ "n", "o", "x", "v" }, "gp", '"+p', opt("Paste after cursor"))
  map("n", "gY", '"+y$', opt("Yank line"))
  map("n", "gP", '"+P', opt("Paste before cursor"))
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
map("n", "<leader>wd", "<c-w>c", { desc = "Window » Delete" })
if Util.call("smart-splits") == nil then
  map("n", "<c-h>", "<c-w>h", { remap = true, desc = "Window » Navigate left" })
  map("n", "<c-j>", "<c-w>j", { remap = true, desc = "Window » Navigate down" })
  map("n", "<c-k>", "<c-w>k", { remap = true, desc = "Window » Navigate up" })
  map("n", "<c-l>", "<c-w>l", { remap = true, desc = "Window » Navigate right" })
  map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
  map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
  map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
  map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
end

-- buffers
map("n", "<leader>`", "<cmd>e #<cr>", { silent = true, desc = "Buffer » Switch to other" })
map("n", "<leader>bb", "<cmd>e #<cr>", { silent = true, desc = "Buffer » Switch to other" })
map("n", "[b", ":bprevious<cr>", { silent = true, desc = "Buffer » Prev" })
map("n", "]b", ":bnext<cr>", { silent = true, desc = "Buffer » Next" })

if Util.call("mini.bufremove") == nil then
  map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
  map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
end

---floating terminal
local ft = function(cmd, root)
  local opt = { size = { width = 0.6, height = 0.7 }, title = "  " .. (cmd or "Terminal"), title_pos = "right" }
  if root then
    opt.cwd = LazyUtil.get_root()
  end
  LazyUtil.float_term(cmd, opt)
end
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Float » Terminal hide" })
map("n", "<leader>fh", function()
  ft("btop")
end, { desc = "Float » Open htop/btop" })
map("n", "<leader>fT", function()
  ft(nil)
end, { desc = "Float » Terminal (curr dir)" })
map("n", "<leader>ft", function()
  ft(nil, true)
end, { desc = "Float » Terminal (root dir)" })
map("n", [[<c-\>]], function()
  ft(nil, true)
end, { desc = "Float » Terminal open (root dir)" })
map("n", "<leader>fz", function()
  vim.cmd([[call system('zmux')]])
end, { desc = "Float » Tmux Z" })

---lazygit
local lz = function(opts)
  LazyUtil.float_term(
    "lazygit",
    vim.tbl_extend("force", opts or {}, {
      title_pos = "right",
      title = "  LazyGit ",
      border = "rounded",
      ctrl_hjkl = false,
      esc_esc = false,
    })
  )
end
map("n", "<leader>gg", function()
  lz()
end, { desc = "Git » Open lazygit (curr dir)" })
map("n", "<leader>gG", function()
  lz({ cwd = LazyUtil.get_root() })
end, { desc = "Git » Open lazygit (root dir)" })

-- toggle options
map("n", "<leader>us", function()
  LazyUtil.toggle("spell")
end, { desc = "Toggle » Spelling" })
map("n", "<leader>uw", function()
  LazyUtil.toggle("wrap")
end, { desc = "Toggle » Word Wrap" })
map("n", "<leader>ud", LazyUtil.toggle_diagnostics, { desc = "Toggle » Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>ul", function()
  LazyUtil.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle » Conceal level" })
map("n", "<leader>uw", function()
  LazyUtil.toggle("wrap")
end, { desc = "Toggle » Word wrap" })
map("n", "<leader>us", function()
  LazyUtil.toggle("spell")
end, { desc = "Toggle » Word spell" })
map("n", "<leader>uc", function()
  LazyUtil.toggle("cursorline")
end, { desc = "Toggle » Cursor line" })
map("n", "<leader>un", function()
  LazyUtil.toggle("relativenumber", true)
  LazyUtil.toggle("number")
end, { desc = "Toggle » Line numbers" })

-- Clear search, diff update and redraw
map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Toggle » Redraw / clear hlsearch / diff update" }
)

map("n", "<leader>uf", function()
  require("lazyvim.plugins.lsp.format").toggle()
end, { desc = "Toggle » Format on Save" })

if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = "Toggle » Inlay hint" })
end
