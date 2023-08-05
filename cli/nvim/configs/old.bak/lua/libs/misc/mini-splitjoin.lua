---@type LazySpec
return {
  'echasnovski/mini.splitjoin',
  config = function()
    require("mini.splitjoin").setup()
    require("which-key").register({
      ["gS"] = {
        name = "Toggle » Split/join"
      }
    })
  end
}
