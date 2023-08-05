local M = {}

---@param msg string
---@param prefix string | nil
M.log = function(msg, prefix)
  if not rnv.opt.dev then
    return
  end
  prefix = prefix or "Log"
  prefix = string.format("[%s]", prefix)
  vim.api.nvim_echo({ { prefix, "Type" }, { " » " .. msg } }, true, {})
end

---display a warning message on console only for while in a dev mode
---@param msg string
---@param prefix string | nil
M.warn = function(msg, prefix)
  if not rnv.opt.dev then
    return
  end
  prefix = prefix or "Warn"
  prefix = string.format("[%s]", prefix)
  vim.api.nvim_echo({ { prefix, "Label" }, { " » " .. msg } }, true, {})
end

---@param arg string
---@return boolean
M.is_empty_string = function(arg)
  return arg == nil or arg == ""
end

---@param opt string
---@return table | nil
M.get_buf_opt = function(opt)
  local okay, buf_opt = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not okay then
    return nil
  else
    return buf_opt
  end
end

---@param ... any
---@return any | nil
M.call = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  else
    return nil
  end
end

---check a given path is of type file or not
---@param path string
---@return boolean
M.is_file = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

---check a given path is a directory or not
---@param path string
---@return boolean
M.is_directory = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

---@param mode string | table
---@param lhs string
---@param rhs string | function
---@param opts table<string,any> | nil
M.map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_deep_extend("force", { silent = true, noremap = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

---@return boolean
M.is_not_empty_buffer = function()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

---@param hlGroup string
---@param opts table | nil
M.set_hl = function(hlGroup, opts)
  vim.api.nvim_set_hl(0, hlGroup, opts or {})
end

---@return boolean
M.is_git_workspace = function()
  local filepath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

return M
