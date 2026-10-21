-- lua/plugins/smart-splits.lua
return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  opts = { move = { at_edge = "wrap" } }, -- 在边缘时循环切换
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "向左切屏" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "向下切屏" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "向上切屏" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "向右切屏" },
  },
}
