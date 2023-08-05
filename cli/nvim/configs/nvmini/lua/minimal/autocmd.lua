require("minimal.util").log("Loading autocommands...")

local function augroup(name)
  return vim.api.nvim_create_augroup("nvmini_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_on_yanked"),
  callback = function()
    vim.highlight.on_yank({ timeout = 99 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("goto_last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

if minimal.colorscheme == "catppuccin" and minimal.transbg then
  vim.api.nvim_create_autocmd("BufReadPre", {
    group = augroup("change_cursor_line_bg"),
    pattern = "*",
    callback = function()
      local bg = minimal.palette.bg2
      vim.cmd.highlight("CursorLine guibg=" .. bg)
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("escape with <q>"),
  pattern = require("minimal.filetype").Windows,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.wo.foldcolumn = "0"
    vim.keymap.set("n", "q", ":close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_and_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
