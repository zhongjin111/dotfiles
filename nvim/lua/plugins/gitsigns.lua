-- lua/plugins/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  opts = {},
  keys = {
    { "]c", function() require("gitsigns").next_hunk() end, desc = "下一个 Git 块" },
    { "[c", function() require("gitsigns").prev_hunk() end, desc = "上一个 Git 块" },
    { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "预览 Git 块" },
    { "<leader>gb", function() require("gitsigns").blame_line() end, desc = "Git Blame" },
  },
}
