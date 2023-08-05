--- @type LazySpec
local M = {}
M[1] = "HiPhish/nvim-ts-rainbow2"
M.event = "BufReadPre"
M.enabled = function()
  return rnv.opt.tsrainbow and not rnv.opt.minimal_mode
end
M.dependencies = "nvim-treesitter"
M.config = function()
  local rainbow = require("ts-rainbow")
  require("nvim-treesitter.configs").setup({
    rainbow = {
      enable = true,
      strategy = rainbow.strategy.global,
      query = {
        "rainbow-parens",
        html = "rainbow-tags",
        latex = "rainbow-blocks",
      },
      hlgroups = {
        "TSRainbowRed",
        "TSRainbowYellow",
        "RnvBlue",
        "TSRainbowOrange",
        "TSRainbowGreen",
        "RnvViolet",
        "RnvCyan",
      },
    },
  })
end
return M
