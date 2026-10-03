-- lua/plugins/overseer.lua
return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen", "OverseerClose" },
  keys = {
    { "<leader>or", "<cmd>OverseerRun<CR>", desc = "运行任务" },
    { "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "任务列表" },
    { "<leader>oa", "<cmd>OverseerQuickAction<CR>", desc = "任务快速操作" },
    { "<leader>ol", "<cmd>OverseerTaskAction<CR>", desc = "任务操作" },
    { "<leader>oo", "<cmd>OverseerOpen<CR>", desc = "打开任务面板" },
    { "<leader>oc", "<cmd>OverseerClose<CR>", desc = "关闭任务面板" },
  },
  opts = {
    strategy = "terminal",
    templates = { "builtin", "user.cpp_build", "user.python_run" },
    task_list = {
      direction = "bottom",
      min_height = 25,
      max_height = 0.4,
      default_detail = 1,
      bindings = {
        ["<C-s>"] = "Start",
        ["<C-k>"] = "Stop",
        ["<C-r>"] = "Restart",
        ["<C-d>"] = "Dispose",
        ["q"] = "Close",
      },
    },
    component_aliases = {
      default = {
        "on_complete_notify",
        "on_complete_dispose",
      },
    },
  },
  config = function(_, opts)
    require("overseer").setup(opts)

    require("which-key").add({
      { "<leader>o", group = "任务运行" },
    })
  end,
}
