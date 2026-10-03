-- lua/plugins/project.lua
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  main = "project_nvim",
  opts = {
    active = true,
    manual_mode = false,
    detection_methods = { "pattern", "lsp" },
    patterns = {
      ".git",
      "Makefile",
      "package.json",
      "Cargo.toml",
      "pyproject.toml",
      "go.mod",
      "CMakeLists.txt",
    },
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)

    -- 集成 Telescope 的 projects picker
    pcall(function()
      require("telescope").load_extension("projects")
    end)

    vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "项目切换" })
  end,
}
