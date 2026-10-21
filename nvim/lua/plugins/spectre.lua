-- lua/plugins/spectre.lua
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>sr", function() require("spectre").toggle() end, desc = "全局搜索替换" },
    { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "替换当前单词" },
  },
}
