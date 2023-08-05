local Icon = require("minimal.icon").Common

return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",

  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  config = function(_, opts)
    local LazyUtil = require("minimal.util")
    local actions = require("telescope.actions")
    local basics = {
      ["<c-t>"] = actions.select_tab,
      ["<c-p>"] = actions.move_selection_previous,
      ["<c-n>"] = actions.move_selection_next,
      ["<c-h>"] = actions.select_horizontal,
      ["<c-v>"] = actions.select_vertical,
      ["<a-d>"] = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyUtil.telescope("find_files", {
          prompt_title = require("common.icons").Common.EyeOpen .. "Find files (no hidden)",
          sorting_strategy = "descending",
          default_text = line,
          no_ignore = true,
          hidden = true,
        })()
      end,
    }

    opts = vim.tbl_deep_extend("force", opts or {}, {
      defaults = {
        layout_config = {
          prompt_position = "top",
          width = 0.9,
        },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        prompt_prefix = " 🔭 ",
        selection_caret = "👉",
        mappings = {
          ["i"] = vim.tbl_extend("force", basics, {
            ["<a-space>"] = actions.close,
            ["<cr>"] = actions.select_default,
            ["<a-j>"] = actions.cycle_history_next,
            ["<a-k>"] = actions.cycle_history_prev,
            ["<c-d>"] = actions.preview_scrolling_down,
            ["<c-u>"] = actions.preview_scrolling_up,
          }),
          ["n"] = vim.tbl_extend("force", basics, {
            ["q"] = actions.close,
            ["<esc>"] = actions.close,
            ["<a-space>"] = actions.close,
            ["<c-p>"] = actions.move_selection_previous,
            ["<c-n>"] = actions.move_selection_next,
            ["<c-h>"] = actions.select_horizontal,
            ["<c-v>"] = actions.select_vertical,
          }),
        },
      },
    })

    if minimal.transbg or minimal.colorscheme == "tokyonight" then
      opts.defaults.borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        preview = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
      }
    end

    require("telescope").setup(opts)
  end,

  init = function()
    local Util = require("minimal.util")

    ---register telescope dotfiles on VimEnter here
    vim.api.nvim_create_user_command("TelescopeDotfiles", function()
      Util.telescope("files", { prompt_title = "🔧 DOTFILES", cwd = os.getenv("DOTFILES") })()
    end, { desc = "Telescope » Open dotfiles" })

    ---register custom note trigger
    vim.api.nvim_create_user_command("TelescopeNotes", function()
      Util.telescope("find_files", {
        prompt_title = Icon.Note .. "Find notes",
        cwd = os.getenv("HOME") .. "/Documents/obsidian-vault",
      })()
    end, { desc = "Telescope » Find notes" })
  end,

  keys = function()
    local LazyUtil = require("minimal.util")

    ---@param lhs string
    ---@param cmd string | function
    ---@param desc string
    local Kmap = function(lhs, cmd, desc)
      return {
        lhs,
        cmd,
        desc = string.format("Telescope » %s", desc),
        silent = true,
      }
    end
    return {
      Kmap("<leader>/N", ":TelescopeNotes<cr>", "Find notes"),
      Kmap("<leader>/d", ":TelescopeDotfiles<cr>", "Find dotfiles"),
      Kmap("<leader>/m", ":Telescope man_pages<cr>", "Find man pages"),
      Kmap("<leader>/g", ":Telescope git_branches<cr>", "Git branches"),
      Kmap("<leader>/o", ":Telescope vim_options<cr>", "Find vim options"),
      Kmap("<leader>/:", ":Telescope command_history<cr>", "Command history"),
      Kmap("<leader>/c", ":Telescope commands<cr>", "Find available commands"),
      Kmap("<leader>/X", ":Telescope diagnostics<cr>", "Workspace diagnostics"),
      Kmap("<leader>/x", ":Telescope diagnostics bufnr=0<cr>", "Find diagnostics (cwd)"),

      Kmap(
        "<leader>/k",
        LazyUtil.telescope("keymaps", {
          prompt_title = Icon.Keyboard .. "Keymaps",
        }),
        "Find keymaps"
      ),

      Kmap(
        "<leader>/H",
        LazyUtil.telescope("highlights", { prompt_title = Icon.ColorMode .. "Highlights" }),
        "Find highlights"
      ),

      Kmap("<f1>", LazyUtil.telescope("help_tags", { prompt_title = Icon.Question .. " Help tags" }), "Find help tags"),

      Kmap(
        "<leader>//",
        LazyUtil.telescope("resume", { prompt_title = Icon.Continue .. "Continue" }),
        "Continue last action"
      ),

      Kmap(
        "<c-p>",
        LazyUtil.telescope("find_files", { prompt_title = Icon.File .. "Files (cwd)" }),
        "Find files (cwd)"
      ),

      Kmap(
        "<leader>/f",
        LazyUtil.telescope("find_files", {
          prompt_title = Icon.File .. "Files (root)",
          cwd = false,
        }),
        "Find files (root)"
      ),

      Kmap(
        "<leader>/w",
        LazyUtil.telescope("live_grep", {
          prompt_title = Icon.Word .. "Grep word",
          layout_strategy = "vertical",
        }),
        "Grep word (cwd)"
      ),

      Kmap(
        "<leader>/W",
        LazyUtil.telescope("live_grep", {
          prompt_title = Icon.Word .. "Grep word",
          layout_strategy = "vertical",
          cwd = false,
        }),
        "Grep word (root)"
      ),

      Kmap(
        "<leader>/C",
        LazyUtil.telescope("colorscheme", {
          prompt_title = Icon.ColorPalette .. "Colorscheme",
          enable_preview = true,
        }),
        "Colorscheme"
      ),

      Kmap(
        "<leader>/p",
        LazyUtil.telescope("find_files", {
          prompt_title = Icon.Package .. "Find plugins",
          cwd = vim.fn.stdpath("data"),
        }),
        "Find plugins"
      ),

      Kmap(
        "<leader><tab>",
        LazyUtil.telescope("oldfiles", {
          prompt_title = Icon.RecentFiles .. "Recent files",
          initial_mode = "normal",
          cwd = vim.loop.cwd(),
        }),
        "Most recent used (cwd)"
      ),

      Kmap(
        "<leader>/r",
        LazyUtil.telescope("oldfiles", {
          prompt_title = Icon.RecentFiles .. "Recent files",
          cwd = vim.loop.cwd(),
        }),
        "Recent files (cwd)"
      ),

      Kmap(
        "<leader>/R",
        LazyUtil.telescope("oldfiles", {
          prompt_title = Icon.RecentFiles .. "Recent files (root)",
          initial_mode = "normal",
        }),
        "Most recent used (root)"
      ),

      Kmap(
        "<leader>/S",
        LazyUtil.telescope("grep_string", {
          prompt_title = Icon.String .. "Grep string",
          layout_strategy = "vertical",
        }),
        "Grep string (cwd)"
      ),

      Kmap(
        "<leader>/s",
        LazyUtil.telescope("grep_string", {
          prompt_title = Icon.String .. "Grep string",
          layout_strategy = "vertical",
          cwd = false,
        }),
        "Grep string (root)"
      ),

      Kmap(
        "<leader>'",
        LazyUtil.telescope("marks", {
          prompt_title = Icon.Marker .. "Marks",
          initial_mode = "normal",
        }),
        "Find marks"
      ),

      Kmap(
        "<leader>;",
        LazyUtil.telescope("jumplist", {
          prompt_title = Icon.Reverse .. "Jump list",
          initial_mode = "normal",
        }),
        "Jump list"
      ),

      Kmap(
        "<leader>,",
        -- LazyUtil.telescope("buffers", {
        --   prompt_title = Icon.RootFolderOpened .. "Opened buffers",
        --   ignore_current_buffer = true,
        --   initial_mode = "normal",
        --   sort_lastused = true,
        --   sort_mru = true,
        -- }),
        ":Telescope buffers ignore_current_buffer=true initial_mode=normal sort_lastused=true sort_mru=true<cr>",
        "Find opened buffers"
      ),
    }
  end,
}
