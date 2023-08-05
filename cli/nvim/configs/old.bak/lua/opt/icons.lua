local M = {}

M.Action = {
  Modify = "●",
  ModifyAlt = "",
  Close = "",
  CloseAlt = "",
  Check = "",
  Select = "",
}

M.Arrow = {
  Left = "",
  Right = "",
}

M.Common = {
  Airplane = "✈",
  Block = "▊",
  BookMark = "",
  Bug = "",
  Calendar = "",
  Code = "",
  Cog = "⚙",
  Comment = "",
  Dashboard = "",
  Envelope = "✉",
  Evil = "",
  File = "",
  Fire = "",
  Flag = "⚐",
  FlagFilled = "⚑",
  Gear = "",
  Gears = "",
  History = "",
  List = "",
  Lock = "",
  NewFile = "",
  Note = "",
  Package = "",
  Pencil = " ",
  Pencil2 = "✎",
  Project = "",
  Scissors = "✂",
  Search = "",
  SignIn = "",
  Snowflake = "❄",
  Star = "☆",
  StarFilled = "★",
  Symlink = "",
  SymlinkArrow = "➛",
  Table = "",
}

M.Chevron = {
  Left = "<",
  LeftBig = "",
  LeftBigFilled = "",
  Right = ">",
  RightBig = "",
  RightBigFilled = "",
}

M.Circle = {
  Tiny = " ",
  Big = " ",
  BigOutline = " ",
  LeftHalf = "",
  RightHalf = "",
}

M.Diagnostics = {
  Error = " ",
  Hint = " ",
  Info = " ",
  Warn = " ",
}

M.DiagnosticsFilled = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

M.Folder = {
  ArrowOpened   = "",
  ArrowClosed   = "",
  Default       = "",
  Opened        = "",
  Empty         = "",
  EmptyOpened   = "",
  Symlink       = "",
  SymlinkOpened = "",
}

M.Git = {
  Branch = "",
  Gitlab = "",
  Github = "󰊤",
  Copilot = "",
  Added = "",
  AddedFilled = "",
  Staged = "",
  StagedFilled = "",
  Unstaged = "󰅘",
  UnstagedFilled = "󰅗",
  Modified = "",
  Unmerged = "",
  Renamed = "",
  Deleted = "",
  DeletedFilled = "",
  Untracked = "",
  Ignored = "",
  Conflict = "",
}

M.KindIcons = {
  Copilot = " ",
  Array = " ",
  Boolean = "◩ ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = "ﳠ ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = "﬌ ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

M.Lsp = {
  server_installed = "✓",
  server_pending = "➜",
  server_uninstalled = "✗",
}

M.Misc = {
  Horse = "♞",
  Lightbulb = "",
  Squirrel = " ",
  Telescope = "",
  YinYang = "☯",
  Vim = " ",
}

M.SpinnerFrames = {
  "⠋ ",
  "⠙ ",
  "⠹ ",
  "⠸ ",
  "⠼ ",
  "⠴ ",
  "⠦ ",
  "⠧ ",
  "⠇ ",
  "⠏ ",
}

M.SpinnerFramesAlt = {
  "🌑 ",
  "🌒 ",
  "🌓 ",
  "🌔 ",
  "🌕 ",
  "🌖 ",
  "🌗 ",
  "🌘 ",
}

M.api = {
  get_webdevicons = function()
    return {
      ["guard.ts"] = {
        icon = "",
        color = "#0BEB64",
        name = "AngularGuard",
      },
      ["service.ts"] = {
        icon = "",
        color = "#EBBA0B",
        name = "AngularService",
      },
      ["component.ts"] = {
        icon = "",
        color = "#549FDD",
        name = "AngularComponent",
      },
      ["cmp.ts"] = {
        icon = "",
        color = "#CD1053",
        name = "AngularComponentStandalone",
      },
      ["module.ts"] = {
        icon = "",
        color = "#CD1053",
        name = "AngularModule",
      },
      ["routes.ts"] = {
        icon = "",
        color = "#6DD390",
        name = "AngularRoutes",
      },
      ["pipe.ts"] = {
        icon = "",
        color = "#62B2C6",
        name = "AngularPipe",
      },
      ["interface.ts"] = {
        icon = "ﯤ",
        color = "#448BDE",
        name = "TypeScriptInterface",
      },
      ["namespace.ts"] = {
        icon = "",
        color = "#038B52",
        name = "TypeScriptNamespace",
      },
      ["store.ts"] = {
        icon = "",
        color = "#AE61E0",
        name = "AngularStore",
      },
      ["state.ts"] = {
        icon = "",
        color = "#DD68B0",
        name = "AngularState",
      },
      ["actions.ts"] = {
        icon = "",
        color = "#D52F2F",
        name = "StoreActions",
      },
      ["selectors.ts"] = {
        icon = "",
        color = "#EBBA0B",
        name = "StoreSelectors",
      },
      ["effects.ts"] = {
        icon = "",
        color = "#448BDE",
        name = "StoreEffects",
      },
      ["angular.json"] = {
        icon = "",
        color = "#D52F2F",
        name = "AngularJson",
      },
    }
  end

}

return M
