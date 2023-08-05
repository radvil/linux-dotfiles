local M = {}

M.treesitter = {
  "bash",
  "css",
  "diff",
  "go",
  "graphql",
  "html",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  "norg",
  "org",
  "python",
  "query",
  "regex",
  "rust",
  "scss",
  "toml",
  "vim",
  "yaml",
}

M.excludes = {
  "NeogitStatus",
  "Dashboard",
  "alpha",
  "noice",
  "help",
}

M.sidebars = {
  "dbui",
  "DiffviewFiles",
  "Mundo",
  "MundoDiff",
  "NvimTree",
  "neo-tree",
  "neo-tree-popup",
  "Outline",
  "edgy",
  "dirbuf",
  "qf",
  "WhichKey",
  "fugitive",
  "fugitiveblame",
  "gitcommit",
  "Trouble",
}

M.popups = {
  "DressingInput",
  "lazy",
  "lspinfo",
  "mason",
  "neo-tree-popup",
  "notify",
  "oil",
  "prompt",
  "TelescopePrompt",
  "TelescopeResults",
}

vim.list_extend(M.excludes, M.sidebars)
vim.list_extend(M.excludes, M.popups)

M.builtin_plugins_excludes = {
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
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
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
