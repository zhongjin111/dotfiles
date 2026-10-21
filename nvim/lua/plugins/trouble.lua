return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "诊断列表" },
    { "<leader>xD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "当前 buffer 诊断" },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "符号列表" },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP 列表" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
    require("which-key").add({ { "<leader>x", group = "诊断/列表" } })
  end,
}
