---@type LazySpec[]
local M = {}
M[1] = "neovim/nvim-lspconfig"
M.event = { "BufReadPre", "BufNewFile" }

M.dependencies = {
  "mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = true,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    cond = function()
      return require("common.utils").has("nvim-cmp")
    end,
  },
}

---@class PluginLspOpts
M.opts = {
  capabilities = {},
  format_notify = false,
  autoformat = true,
  format = {
    formatting_options = nil,
    timeout_ms = nil,
  },
  inlay_hints = {
    enabled = rnv.opt.lsp_inlay_hint,
  },
  icons = require("opt.icons").DiagnosticsFilled,
  diagnostics = {
    update_in_insert = false,
    severity_sort = true,
    underline = true,
    float = {
      border = rnv.opt.transbg or rnv.opt.minimal_mode and "rounded" or "none",
    },
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
  },
  ---@type lspconfig.options
  servers = {
    html = {},
    cssls = {},
    bashls = {},
    lua_ls = {
      ---false means dont install using mason
      -- mason = false,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
  },
  -- return true for standalone server without lspconfig
  ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  setup = {
    -- tsserver = function(_, opts)
    --   require("typescript").setup({ server = opts })
    --   return true
    -- end,
    -- Specify * to use this function as a fallback for any server
    -- ["*"] = function(server, opts) end,
  },
}

---@param opts PluginLspOpts
M.config = function(_, opts)
  require("libs.lsp.diagnostics").setup(opts)
  require("libs.lsp.formatting").setup(opts)
  require("libs.lsp.keymapping").setup()

  local function setup(server)
    local setup_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(
        vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities(),
          opts.capabilities or {}
        )
      ),
    }, opts.servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, setup_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, setup_opts) then
        return
      end
    end
    require("lspconfig")[server].setup(setup_opts)
  end

  -- Get all the servers that are available via mason-lspconfig
  local mlsp_servers = {}
  local ensure_installed = {} ---@type string[]
  local mlsp = rnv.api.call("mason-lspconfig")

  if mlsp then
    local server_maps = require("mason-lspconfig.mappings.server")
    mlsp_servers = vim.tbl_keys(server_maps.lspconfig_to_package)
  end

  for name, options in pairs(opts.servers) do
    if options then
      options = options == true and {} or options
      -- Run manual setup if mason=false
      -- or if this is a server that cannot be installed with mason-lspconfig
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
