return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "haydenmeade/neotest-jest",
  },
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end, desc = "运行最近测试" },
    { "<leader>tR", function() require("neotest").run.run_last() end, desc = "运行上次测试" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "运行当前文件测试" },
    { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "运行所有测试" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "测试摘要" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "测试输出" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "测试输出面板" },
    { "<leader>tw", function() require("neotest").watch.toggle() end, desc = "监视测试" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "调试测试" },
    { "<leader>tq", function() require("neotest").run.stop() end, desc = "停止测试" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          runner = "pytest",
          args = { "-s", "--no-header" },
        }),
        require("neotest-go")({
          experimental = { test_table = true },
          args = { "-v", "-count=1" },
        }),
        require("neotest-rust")({ args = { "--no-capture" } }),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.{js,ts,mjs,cjs}",
          env = { CI = true },
        }),
      },
      summary = { animated = true, expand_errors = true, follow = true },
      output = { open_on_run = true },
      quickfix = { enabled = false },
      icons = {
        passed = "✓",
        failed = "✗",
        running = "⟳",
        skipped = "○",
        unknown = "?",
      },
    })
    require("which-key").add({ { "<leader>t", group = "测试" } })
  end,
}
