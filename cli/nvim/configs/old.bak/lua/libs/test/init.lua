---@type LazySpec[]
if not rnv.opt.dev then
  return {}
end

---@type LazySpec[]
---Test code here...

---end of test
return {
  require("libs.test.hackertype"),
}
