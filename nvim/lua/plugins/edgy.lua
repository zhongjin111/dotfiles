-- lua/plugins/edgy.lua
return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  opts = {
    left = {}, -- 不要接管 neo-tree
    options = { left = { size = 30 } },
  },
}
