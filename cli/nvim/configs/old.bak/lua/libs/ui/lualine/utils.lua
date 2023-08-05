---@diagnostic disable: undefined-field
local M = {}

M.custom_labels = {
  ["angularls"] = "Angular 2+",
  ["tsserver"] = "Typescript",
  ["lua_ls"] = "Lua",
}

M.get_filesize = function()
  local file = vim.fn.expand("%:p")
  if file == nil or #file == 0 then
    return ""
  end
  local size = vim.fn.getfsize(file)
  if size <= 0 then
    return ""
  end
  local suffixes = { "b", "k", "m", "g" }
  local i = 1
  while size > 1024 and i < #suffixes do
    size = size / 1024
    i = i + 1
  end
  local format = i == 1 and "%d%s" or "%.1f%s"
  local fsize = string.format(format, size, suffixes[i])
  return " 🎲 " .. fsize
end

M.get_filename = function()
  local prefix = " ⚓ "
  if rnv.api.get_buf_opt("mod") then
    prefix = " 💋 "
  end
  return prefix .. vim.fn.expand("%:t")
end

M.get_server_names = function()
  local buffer_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local active_clients = vim.lsp.get_active_clients()
  if next(active_clients) ~= nil then
    for _, client in ipairs(active_clients) do
      local file_type = client.config.filetypes
      if file_type and vim.fn.index(file_type, buffer_ft) ~= -1 then
        return M.custom_labels[client.name] or client.name
      end
    end
  end
  return "No Lsp attached"
end

---@param bold? boolean
function M.fg(name, bold)
  return function()
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground), bold = bold or false }
  end
end

---@param group string highlight groyp
---@param opts {content: string; fg: string; bg: string; bold:boolean; padding: string}
---@return string -- formatted name
function M.create_hi(group, opts)
  local pad = opts.padding or ""
  local hi_group = string.format("RvnHiStatusline%s", group)
  local content = pad .. opts.content .. pad
  vim.api.nvim_set_hl(0, hi_group, {
    bold = opts.bold or false,
    fg = opts.fg,
    bg = opts.bg,
  })
  return "%#" .. hi_group .. "#" .. content
end

---@param fallback? string color fallback if result get nil
function M.get_bgcolor(fallback)
  local ret = fallback or rnv.opt.palette.bg
  local bghl = vim.api.nvim_get_hl_by_name("TabLineFill", true)
  if bghl.background ~= nil then
    ret = string.format("#%06x", bghl.background)
  end
  return ret
end

---@param name? string file name
---@param ext? string file extension
function M.get_filemeta(name, ext)
  local icon = require("opt.icons").Common.File
  local color = M.get_bgcolor()
  if require("nvim-web-devicons").has_loaded() then
    ext = ext or vim.fn.expand("%:e")
    name = name or vim.fn.expand("%:t")
    icon, color = require("nvim-web-devicons").get_icon_color(name, ext)
  end
  return { icon = icon, color = color }
end

return M
