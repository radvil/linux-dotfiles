---@type LazySpec
local M = {}

M[1] = "neovim/nvim-lspconfig"

M.event = {
  "BufReadPre",
  "BufNewFile",
}

M.dependencies = {
  "mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    dependencies = { "nvim-lspconfig" },
    ---@diagnostic disable-next-line: assign-type-mismatch
    config = false,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    cond = function()
      return require("minimal.util").has("nvim-cmp")
    end,
  },
}

---@class PluginLspOpts
M.opts = {
  capabilities = {},
  diagnostics = {
    float = { border = "rounded" },
    update_in_insert = false,
    severity_sort = true,
    underline = true,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "icons", -- "●",
    },
  },
  ---@class PluginLspFormatOpts
  format = {
    notify = minimal.dev,
    autoformat = true,
    params = {
      formatting_options = nil,
      timeout_ms = nil,
      bufnr = 0,
    },
  },
  servers = {
    bashls = {},
    html = {},
    cssls = {},
    lua_ls = {
      mason = true,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
          hint = {
            enable = true,
            setType = true,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
        },
      },
    },
  },
  -- return true for setup is standalone (without lspconfig)
  ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  standalone_setups = {
    -- tsserver = function(_, opts)
    --   require("typescript").setup({ server = opts })
    --   return true
    -- end,
    -- Specify * to use this function as a fallback for any server
    -- ["*"] = function(server, opts) end,
  },
  ---@class PluginLspMappingOpts
  mappings = {
    enable_defaults = minimal.lsp_default_mappings,
    ---@param client lsp.Client
    ---@param bufnr number
    on_attach = function(client, bufnr)
      if client.server_capabilities["documentSymbolProvider"] then
        if require("minimal.util").has("nvim-navic") then
          require("nvim-navic").attach(client, bufnr)
        end
      end
      if client.server_capabilities.renameProvider then
        if require("minimal.util").has("inc-rename.nvim") then
          vim.keymap.set("n", "<leader>cr", function()
            return ":" .. require("inc_rename").config.cmd_name .. " " .. vim.fn.expand("<cword>")
          end, {
            desc = "Rename under cursor",
            buffer = bufnr,
            silent = true,
            expr = true,
          })
        else
          vim.keymap.set("n", "<leader>cr", ":CR<cr>", {
            desc = "Rename under cursor",
            buffer = bufnr,
          })
        end
      end
    end,
  },
  prehook = function()
    if minimal.transbg then
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end

    vim.keymap.set("n", "<leader>uf", function()
      require("libs.lsp.format").toggle()
    end, { desc = "Toggle » Format on save" })

    ---@param client lsp.Client
    require("minimal.util").on_lsp_attach(function(client, bufnr)
      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
      local active = minimal.lsp_inlay_hint
      if inlay_hint and client.supports_method("textDocument/inlayHint") then
        -- vim.lsp.buf.inlay_hint(bufnr, active)
        inlay_hint(bufnr, active)
        vim.keymap.set("n", "<leader>uh", function()
          active = not active
          inlay_hint(bufnr, active)
          vim.notify(
            "LSP » Inlay hint " .. (active and "enabled" or "disabled") .. string.format(" [%s]", bufnr),
            vim.log.levels[active and "INFO" or "WARN"]
          )
        end, { buffer = bufnr, desc = "Toggle » Inlay hints" })
      end
    end)

    ---@param name string
    ---@param cb function | string
    ---@param desc string
    local cmd = function(name, cb, desc)
      return vim.api.nvim_create_user_command("C" .. name, cb, { desc = "LSP » " .. desc })
    end
    cmd("R", "lua vim.lsp.buf.rename()", "Rename under cursor")
    cmd("A", "lua vim.lsp.buf.code_action()", "Code action")
    cmd("D", "Telescope lsp_definitions", "Find definitions")
    cmd("V", vim.lsp.buf.signature_help, "Signature help")
    cmd("I", "Telescope lsp_implementations", "Find implementations")
    cmd("L", "Telescope lsp_references", "Find references")
    cmd("T", "Telescope lsp_type_definitions", "Find type defintions")
  end,
}

---@param opts PluginLspOpts
M.config = function(_, opts)
  if opts.prehook then
    opts.prehook()
  end

  if require("minimal.util").has("neoconf.nvim") then
    local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
    require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
  end

  require("libs.lsp.diagnostic").setup(opts.diagnostics)
  require("libs.lsp.keymap").setup(opts.mappings)
  require("libs.lsp.format").setup(opts.format)

  local function setup(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    local setup_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(
        vim.tbl_deep_extend(
          "force",
          {},
          capabilities,
          require("cmp_nvim_lsp").default_capabilities(),
          opts.capabilities or {}
        )
      ),
    }, opts.servers[server] or {})
    if opts.standalone_setups[server] then
      if opts.standalone_setups[server](server, setup_opts) then
        return
      end
    elseif opts.standalone_setups["*"] then
      if opts.standalone_setups["*"](server, setup_opts) then
        return
      end
    end
    require("lspconfig")[server].setup(setup_opts)
  end

  local mlsp_servers = {}
  local ensure_installed = {}
  local mlsp_ok, mlsp = pcall(require, "mason-lspconfig")

  if mlsp_ok then
    local server_pairs = require("mason-lspconfig.mappings.server")
    mlsp_servers = vim.tbl_keys(server_pairs.lspconfig_to_package)
  end

  for name, options in pairs(opts.servers) do
    if options then
      options = options == true and {} or options
      if options.mason == false or not vim.tbl_contains(mlsp_servers, name) then
        setup(name)
      else
        ensure_installed[#ensure_installed + 1] = name
      end
    end
  end

  if mlsp then
    mlsp.setup({
      ensure_installed = ensure_installed,
      handlers = {
        setup,
      },
    })
  end
end

return M
