return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    picker = "telescope",
    enable_builtin = true,
  },
  keys = {
    { "<leader>gi", "<CMD>Octo issue list<CR>",        desc = "GitHub Issues" },
    { "<leader>gP", "<CMD>Octo pr list<CR>",           desc = "GitHub PullRequests" },
    { "<leader>gd", "<CMD>Octo discussion list<CR>",   desc = "GitHub Discussions" },
    { "<leader>gn", "<CMD>Octo notification list<CR>", desc = "GitHub Notifications" },
    {
      "<leader>gs",
      function()
        require("octo.utils").create_base_search_command { include_current_repo = true }
      end,
      desc = "GitHub Search",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}
