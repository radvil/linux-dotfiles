return {
  "letieu/hacker.nvim",
  opts = {
    content = [[ Code want to show.... ]], -- The code snippet that show when typing
    filetype = "lua",                      -- filetype of code snippet
    speed = {
      -- characters insert each time, random from min -> max
      min = 2,
      max = 5,
    },
    is_popup = false, -- show random float window when typing
    popup_after = 5,
  }
}
