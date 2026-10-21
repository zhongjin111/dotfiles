return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "查找 / 格式化" },
      { "<leader>g", group = "Git / GitHub" },
      { "<leader>o", group = "任务运行" },
      { "<leader>x", group = "诊断 / 列表" },
      { "<leader>d", group = "调试" },
      { "<leader>c", group = "代码" },
      { "<leader>r", group = "重命名" },
      { "<leader>t", group = "测试" },
      { "<leader>a", group = "大纲" },
      { "<leader>b", group = "Buffer" },
      { "<leader>p", group = "项目" },
      { "<leader>e", desc = "文件管理" },
    },
  },
}
