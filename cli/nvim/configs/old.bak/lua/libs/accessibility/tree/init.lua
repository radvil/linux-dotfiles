local function getconfig(name)
  return require(string.format("libs.accessibility.tree.%s", name))
end
---@type LazySpec[]
return {
  getconfig("symbols-outline"),
  getconfig("nvim-tree"),
  getconfig("neotree"),
  getconfig("edgy"),
}
