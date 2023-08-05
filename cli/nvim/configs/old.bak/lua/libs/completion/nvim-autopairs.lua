---@type LazySpec
local M = {}
M[1] = "windwp/nvim-autopairs"
M.opts = {
  fast_wrap = {},
  disable_filetype = require("opt.filetype").excludes,
  disable_in_visualblock = true, -- on insert after visual block
}
M.config = function(_, opts)
  require("nvim-autopairs").setup(opts)
  -- setup cmp for autopairs
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
return M
