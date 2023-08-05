local M = {}

local icons = require("opt.icons")
local utils = require("libs.ui.lualine.utils")
local palette = rnv.opt.palette
local bgcolor = utils.get_bgcolor(palette.bg)
local vmodecolor = {
  n = palette.red,
  i = palette.green,
  v = palette.orange,
  [""] = palette.orange,
  V = palette.orange,
  c = palette.magenta,
  no = palette.red,
  s = palette.pink,
  S = palette.pink,
  [""] = palette.pink,
  ic = palette.cyan,
  R = palette.violet,
  Rv = palette.violet,
  cv = palette.blue,
  ce = palette.blue,
  r = palette.magenta,
  rm = palette.magenta,
  ["r?"] = palette.magenta,
  ["!"] = palette.red,
  t = palette.red,
}

--M.extensions = { "neo-tree", "lazy" }

M.options = {
  disabled_filetypes = { "alpha", "Dashboard" },
  component_separators = "",
  section_separators = "",
  icons_enabled = false,
  globalstatus = true,
  theme = "auto",
}

M.sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_y = {},
  lualine_z = {},
  lualine_c = {},
  lualine_x = {},
}

M.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_y = {},
  lualine_z = {},
  lualine_c = {},
  lualine_x = {},
}

local function insert_left(changes)
  table.insert(M.sections.lualine_c, changes or {})
end

local function insert_right(changes)
  table.insert(M.sections.lualine_x, changes or {})
end

--@alias VType string | function
--@param colors {left: VType; middle: VType; right: VType}
--@param cond? boolean | function default to true
local function insert_arrow(colors, cond)
  if type(cond) == "function" then
    cond = cond()
  elseif type(cond) == "boolean" then
    cond = cond
  else
    cond = true
  end
  if not cond then
    return
  end
  local function val(c)
    if type(c) == "function" then
      return c()
    else
      return c
    end
  end
  insert_left({
    function()
      return icons.Chevron.RightBigFilled
    end,
    padding = 0,
    color = function()
      return {
        fg = val(colors.left),
        bg = val(colors.middle),
      }
    end,
  })
  insert_left({
    function()
      return icons.Chevron.RightBigFilled
    end,
    padding = 0,
    color = function()
      return {
        fg = val(colors.middle),
        bg = val(colors.right),
      }
    end,
  })
end

---vim mode
insert_left({
  "mode",
  fmt = function(str)
    return icons.Misc.Vim .. str
  end,
  color = function()
    return {
      bg = vmodecolor[vim.fn.mode()],
      fg = bgcolor,
      gui = "bold",
    }
  end,
})

if vim.g.neovide then
  insert_left({
    function()
      return icons.Git.Branch
    end,
    color = function()
      return {
        bg = palette.orange,
        fg = bgcolor,
      }
    end,
  })

  ---git branch
  insert_left({
    "branch",
    icon = icons.Common.Git,
    color = {
      bg = palette.yellow,
      fg = bgcolor,
      gui = "bold",
    },
    fmt = function(str)
      if str == "" or str == nil then
        return "<empty>"
      end
      return str
    end,
  })
else
  insert_arrow({
    left = function()
      return vmodecolor[vim.fn.mode()]
    end,
    middle = palette.orange,
    right = function()
      return rnv.api.is_git_workspace() and utils.get_filemeta().color or ""
    end,
  })
end

---file's icon + name
insert_left({
  "filename",
  padding = 0,
  cond = rnv.api.is_not_empty_buffer,
  fmt = function(filename)
    local separator = icons.Chevron.RightBigFilled
    local meta = utils.get_filemeta(filename)
    local ficon = utils.create_hi("RnvStatusLineFileIconContent", {
      content = meta.icon,
      bg = meta.color,
      fg = bgcolor,
      padding = " ",
    })
    local ficon_suffix = utils.create_hi("RnvStatusLineFileIconSuffix", {
      content = separator,
      bg = palette.green,
      fg = meta.color,
    })
    local fname = utils.create_hi("RnvStatusLineFileName", {
      content = filename,
      bg = palette.green,
      fg = bgcolor,
      padding = " ",
      bold = true,
    })
    local fname_suffix = utils.create_hi("RnvStatusLineFileNameSuffix", {
      content = separator,
      fg = palette.green,
      bg = meta.color,
    })
    return ficon .. ficon_suffix .. fname .. fname_suffix
    -- return ficon .. fname .. fname_suffix
  end,
})

insert_left({
  function()
    return icons.Chevron.RightBigFilled
  end,
  padding = 0,
  cond = rnv.api.is_not_empty_buffer,
  color = function()
    return {
      fg = utils.get_filemeta(utils.get_filename()).color,
    }
  end,
})

---lsp serer's name
insert_left({
  function()
    return utils.get_server_names()
  end,
  color = {
    fg = palette.yellow,
  },
  fmt = function(serverName)
    return "🚀 « " .. serverName .. " »"
  end,
})

---lsp progress
insert_left({
  "lsp_progress",
  display_components = {
    -- "lsp_client_name",
    "spinner",
    -- { "title", "percentage", "message" },
  },
  spinner_symbols = icons.SpinnerFramesAlt,
  color = {
    fg = palette.yellow,
    bg = palette.trans,
  },
})

---lsp diagnostics counts
insert_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    Error = icons.Diagnostics.Error,
    Warn = icons.Diagnostics.Warn,
    Info = icons.Diagnostics.Info,
  },
  diagnostics_color = {
    color_error = { fg = palette.red },
    color_info = { fg = palette.blue },
    color_warn = { fg = palette.yellow },
  },
})

---middle separator
insert_left({
  function()
    return "%="
  end,
})

-- ---command status
-- insert_right({
--   function()
--     return require("noice").api.status.command.get()
--   end,
--   cond = function()
--     return package.loaded["noice"] and require("noice").api.status.command.has()
--   end,
--   padding = 0,
--   color = utils.fg("Statement"),
--   fmt = function(cmdstatus)
--     return "« " .. cmdstatus .. " » "
--   end,
-- })

---git signs
insert_right({
  "diff",
  cond = rnv.api.is_git_workspace,
  symbols = {
    added = icons.Git.AddedFilled .. " ",
    modified = icons.Git.UnstagedFilled .. " ",
    removed = icons.Git.DeletedFilled .. " ",
  },
  diff_color = {
    added = { fg = palette.green },
    modified = { fg = palette.yellow },
    removed = { fg = palette.red },
  },
})

---file size
insert_right({
  "filesize",
  cond = rnv.api.is_not_empty_buffer,
  padding = 0,
  color = utils.fg("Special", true),
  fmt = function(filesize)
    return "│ " .. filesize .. " "
  end,
})

---cursor's location progress in percent
insert_right({
  "progress",
  padding = 0,
  color = {
    fg = palette.green,
    gui = "bold",
  },
  fmt = function(progress)
    return "│ " .. progress .. " "
  end,
})

---cursor's vert + hor location
insert_right({
  "location",
  padding = 0,
  color = {
    gui = "bold",
    fg = palette.yellow,
  },
  fmt = function(location)
    return "│ " .. location .. " "
  end,
})

---rightside block
insert_right({
  function()
    return icons.Common.Block
  end,
  padding = 0,
  color = function()
    return {
      fg = vmodecolor[vim.fn.mode()],
    }
  end,
})

return M
