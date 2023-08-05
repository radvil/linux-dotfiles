rnv.api.log("Loading autocommands...", "opt.autocmds")

local function augroup(name)
  return vim.api.nvim_create_augroup("rnv_" .. name, { clear = true })
end

--Check if any buffers were changed outside of Vim.
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_on_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 99 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("goto_last_cursor_location"),
  callback = function()
    local excludes = { "gitcommit" }
    local buffer = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(excludes, vim.bo[buffer].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, buffer, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_window_with_q"),
  pattern = vim.list_extend({ "help" }, require("opt.filetype").sidebars),
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
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("create_dir_if_doesnt_exist"),
  callback = function(e)
    if e.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(e.match) or e.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
