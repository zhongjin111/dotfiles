-- lua/plugins/dropbar.lua
return {
  "Bekaboo/dropbar.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
