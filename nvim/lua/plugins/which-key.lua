-- lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "查找 / 格式化" },
      { "<leader>g", group = "Git" },
      { "<leader>o", group = "任务运行" },
      { "<leader>x", group = "Trouble" },
      { "<leader>d", group = "调试" },
      { "<leader>c", group = "代码" },
      { "<leader>r", group = "重命名" },
      { "<leader>t", group = "测试" },
      { "<leader>a", group = "大纲" },
      { "<leader>p", group = "项目" },
    },
  },
}
