-- lua/plugins/noice.lua
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    notify = { enabled = true },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
