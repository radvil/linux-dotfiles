local M = {}
M[1] = "luukvbaal/statuscol.nvim"
M.enabled = false
M.opts = function()
  local builtin = require("statuscol.builtin")
  return {
    relculright = true,
    segments = {
      { text = { "%s" }, click = "v:lua.ScSa" },
      { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
      { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
    },
  }
end

return M
