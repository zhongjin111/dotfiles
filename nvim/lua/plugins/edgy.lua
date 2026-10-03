return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  opts = {
    left = {
      {
        ft = "neo-tree",
        title = "文件管理",
        wo = {
          winbar = "", -- 隐藏 neo-tree 自带的 winbar（可选）
        },
      },
    },
  },
}
