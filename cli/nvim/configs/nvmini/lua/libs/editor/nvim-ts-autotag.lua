return {
  "windwp/nvim-ts-autotag",
  event = "BufReadPre",
  enabled = function()
    return minimal.autotag
  end,
  opts = {},
}
