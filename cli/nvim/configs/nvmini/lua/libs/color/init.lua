require("minimal.util").log("Loading colorschemes...")

for name, hex_color in pairs(minimal.palette) do
  require("minimal.util").set_hl(name, { fg = hex_color })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if minimal.colorscheme == "tokyonight" then
      vim.cmd([[hi link NeoTreeDirectoryIcon NvimMiniYellow]])
      vim.cmd([[hi link NeoTreeDirectoryName NvimMiniYellow2]])
      -- vim.cmd([[hi link BufferLineBufferSelected NvimMiniYellow]])
      if minimal.transbg then
        vim.cmd([[hi link FloatBorder NvimMiniYellow]])
        vim.cmd([[hi link TelescopeTitle NvimMiniYellow]])
        vim.cmd([[hi link TelescopeBorder NvimMiniYellow]])
        vim.cmd([[hi link TelescopePromptBorder NvimMiniYellow]])
        vim.cmd([[hi link TelescopePreviewBorder NvimMiniYellow]])
        vim.cmd([[hi link TelescopeResultsBorder NvimMiniYellow]])
        vim.cmd([[hi link CmpDocumentationBorder NvimMiniYellow]])
        vim.cmd([[hi link WhichKeyBorder NvimMiniYellow]])
        vim.cmd([[hi link LspInfoBorder NvimMiniYellow]])
        vim.cmd([[hi link NoicePopupmenuBorder NvimMiniYellow]])
        vim.cmd([[hi link NoicePopupBorder NvimMiniYellow]])
        vim.cmd([[hi link NoiceSplitBorder NvimMiniYellow]])
        vim.cmd([[hi link NoiceCmdlineIcon NvimMiniYellow]])
        vim.cmd([[hi link NoiceCmdlinePopupBorder NvimMiniYellow]])
        vim.cmd([[hi link NoiceCmdlinePopupTitle NvimMiniYellow]])
      end
    end
  end,
})

return {
  require("libs.color.catppuccin"),
  require("libs.color.tokyonight"),
  require("libs.color.monokai-pro"),
}
