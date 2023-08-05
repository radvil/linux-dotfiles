local M = {}

M.Treesitter = {
  "bash",
  "css",
  "diff",
  --"go",
  "html",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  --"norg",
  --"org",
  "python",
  "query",
  "regex",
  "toml",
  "vim",
  "yaml",
}

M.Excludes = {
  "NeogitStatus",
  "Dashboard",
  "alpha",
  "help",
}

M.Popups = {
  "noice",
  "flash_prompt",
  "WhichKey",
  "lazy",
  "lspinfo",
  "mason",
  "neo-tree-popup",
  "notify",
  "oil",
  "prompt",
  "TelescopePrompt",
  "TelescopeResults",
  "DressingInput",
  "cmp_menu",
  "noice",
}

M.Windows = {
  "NeogitStatus",
  "prompt",
  "Dashboard",
  "dashboard",
  "alpha",
  "help",
  "dbui",
  "DiffviewFiles",
  "Mundo",
  "MundoDiff",
  "NvimTree",
  "neo-tree",
  "Outline",
  "edgy",
  "dirbuf",
  "qf",
  "fugitive",
  "fugitiveblame",
  "gitcommit",
  "Trouble",
}

vim.list_extend(M.Excludes, M.Windows)
vim.list_extend(M.Excludes, M.Popups)

M.Builtins = {
  "2html_plugin",
  "bugreport",
  "compiler",
  "ftplugin",
  "fzf",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "optwin",
  "rplugin",
  "rrhelper",
  "spellfile_plugin",
  "synmenu",
  "syntax",
  "tar",
  "tarPlugin",
  "tohtml",
  "tutor",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "ruby",
  "gem",
}

return M
