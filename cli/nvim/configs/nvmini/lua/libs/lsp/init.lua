return {
  require("libs.lsp.inc-rename"),
  require("libs.lsp.installer"),
  require("libs.lsp.config"),

  require("libs.lsp.lang.json"),
  require("libs.lsp.lang.rust"),
  require("libs.lsp.lang.emmet"),
  require("libs.lsp.lang.docker"),
  require("libs.lsp.lang.angular"),
  require("libs.lsp.lang.markdown"),
  require("libs.lsp.lang.tailwind"),
  require("libs.lsp.lang.typescript"),

  require("libs.lsp.linter.eslint"),
  require("libs.lsp.linter.null-ls"),
  require("libs.lsp.linter.prettier"),
}
