local ftMap = {
  typescript = nil,
  javascript = nil,
  html = { "treesitter", "indent" },
  python = { "indent" },
  vim = "indent",
  alpha = "",
  git = "",
}

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  dependencies = "kevinhwang91/promise-async",
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "UFO » Open all folds",
    },
    {
      "zr",
      function()
        require("ufo").openFoldsExceptKinds()
      end,
      desc = "UFO » Open folds excepts kinds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "UFO » Close all folds",
    },
    {
      "[z",
      function()
        require("ufo").goPreviousClosedFold()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      desc = "UFO » Peek prev fold",
    },
    {
      "]z",
      function()
        require("ufo").goNextClosedFold()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      desc = "UFO » Peek next fold",
    },
  },
  config = function(_, opts)
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    ---@diagnostic disable
    opts.provider_selector = function(bufnr, filetype, buftype)
      return ftMap[filetype]
    end
    opts.fold_virt_text_handler = handler
    opts.open_fold_hl_timeout = 150
    opts.preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        winhighlight = "Normal:Folded",
        winblend = 0,
      },
    }
    require("ufo").setup(opts)
  end,
}
