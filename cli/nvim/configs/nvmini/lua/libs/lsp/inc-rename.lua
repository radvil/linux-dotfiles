return {
  "smjonas/inc-rename.nvim",
  enabled = function()
    return minimal.inc_rename
  end,
  opts = {
    cmd_name = "IncRename",
    hl_group = "Substitute",
    preview_empty_name = true,
    show_message = false,
    input_buffer_type = nil,
    post_hook = nil,
  },
}
