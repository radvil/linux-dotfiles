---@type LazySpec
return {
  "willothy/flatten.nvim",
  enabled = function()
    return not rnv.opt.minimal_mode
  end,
  opts = function()
    local blacklisted = {}
    for _, value in ipairs(require("opt.filetype").excludes) do
      blacklisted[value] = true
    end
    return {
      allow_cmd_passthrough = true,
      block_for = blacklisted,
      -- callbacks = {
      --   post_open = function(bufnr)
      --     require("common.utils").info("Opening file in bufnr" .. bufnr)
      --   end
      -- },
      window = {
        -- Options:
        -- current        -> open in current window (default)
        -- alternate      -> open in alternate window (recommended)
        -- tab            -> open in new tab
        -- split          -> open in split
        -- vsplit         -> open in vsplit
        -- func(new_file_names, argv, stdin_buf_id) -> only open the files, allowing you to handle window opening yourself.
        -- The first argument is an array of file names representing the newly opened files.
        -- The third argument is only provided when a buffer is created from stdin.
        -- IMPORTANT: For `block_for` to work, you need to return a buffer number.
        --            The `filetype` of this buffer will determine whether block should happen or not.
        open = "current",
        -- Affects which file gets focused when opening multiple at once
        -- Options:
        -- "first"        -> open first file of new files (default)
        -- "last"         -> open last file of new files
        focus = "first",
      },
    }
  end,
}
