local M = {}

M._loaded = false

---@type PluginLspKeys
M._keys = nil

---@type PluginLspMappingOpts
M.opts = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
  local format_document = function()
    require("libs.lsp.format").format({ force = true })
  end
  if not M._keys then
    ---@class PluginLspKeys
    M._keys = {
      { "gd", ":Telescope lsp_definitions reuse_win=true<cr>", desc = "Definitions", has = "definition" },
      { "gT", ":Telescope lsp_type_definitions reuse_win=true<cr>", desc = "Type definitions" },
      { "gI", ":Telescope lsp_implementations reuse_win=true<cr>", desc = "Implementations" },
      { "gr", ":Telescope lsp_references reuse_win=true<cr>", desc = "References" },
      { "gD", vim.lsp.buf.declaration, desc = "Declaration" },
      {
        "K",
        function()
          local ufo = require("minimal.util").call("ufo")
          if not ufo or not ufo.peekFoldedLinesUnderCursor() then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Hover",
        has = "hover",
      },
      {
        "gK",
        vim.lsp.buf.signature_help,
        desc = "Signature help",
        has = "signatureHelp",
      },
      { "<leader>cx", vim.diagnostic.open_float, desc = "Diagnostic open float" },
      {
        "<a-k>",
        vim.lsp.buf.signature_help,
        mode = "i",
        desc = "Signature Help",
        has = "signatureHelp",
      },
      { "]d", M.diagnostic_goto(true), desc = "Next diagnostic" },
      { "[d", M.diagnostic_goto(false), desc = "Prev diagnostic" },
      { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next error" },
      { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev error" },
      { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next warning" },
      { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev warning" },
      {
        "<leader>cf",
        format_document,
        desc = "Format document",
        has = "documentFormatting",
      },
      {
        "<leader>cf",
        format_document,
        has = "documentRangeFormatting",
        desc = "Format range",
        mode = "v",
      },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        desc = "Code action",
        has = "codeAction",
        mode = { "n", "v" },
      },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source" },
              diagnostics = {},
            },
          })
        end,
        desc = "Source action",
        has = "codeAction",
      },
    }
  end
  return M._keys
end

function M.on_attach(client, buffer)
  if M.opts.enable_defaults then
    local Keys = require("lazy.core.handler.keys")
    local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

    for _, value in ipairs(M.get()) do
      local keys = Keys.parse(value)
      if keys[2] == vim.NIL or keys[2] == false then
        keymaps[keys.id] = nil
      else
        keymaps[keys.id] = keys
      end
    end

    for _, keys in pairs(keymaps) do
      if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
        local opts = Keys.opts(keys)
        ---@diagnostic disable-next-line: no-unknown
        opts.has = nil
        opts.silent = opts.silent ~= false
        opts.buffer = buffer
        vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
      end
    end
  end -- OEL enable_defaults

  if M.opts.on_attach then
    M.opts.on_attach(client, buffer)
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

---@param opts PluginLspMappingOpts
function M.setup(opts)
  M.opts = opts
  if not M._loaded then
    require("minimal.util").on_lsp_attach(M.on_attach)
    M._loaded = true
  end
end

return M
