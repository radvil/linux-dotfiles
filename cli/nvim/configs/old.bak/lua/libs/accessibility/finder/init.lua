local function getconfig(name)
  return require(string.format("libs.accessibility.finder.%s", name))
end
return {
  getconfig("todo-comments"),
  getconfig("telescope"),
  getconfig("which-key"),
  getconfig("trouble"),
  getconfig("spectre"),
  getconfig("undodir"),
  getconfig("harpoon"),
  getconfig("flash"),
  getconfig("leap"),
}
