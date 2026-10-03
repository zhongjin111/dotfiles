-- lua/plugins/aerial.lua
return {
  "stevearc/aerial.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>av", "<cmd>AerialToggle<CR>", desc = "代码大纲" },
    { "<leader>ao", "<cmd>AerialOpen<CR>", desc = "打开大纲" },
    { "<leader>ac", "<cmd>AerialClose<CR>", desc = "关闭大纲" },
    { "{", "<cmd>AerialPrev<CR>", desc = "上一个符号" },
    { "}", "<cmd>AerialNext<CR>", desc = "下一个符号" },
  },
  opts = {
    backends = { "lsp", "treesitter" },
    layout = {
      min_width = 30,
      default_direction = "right",
      placement = "edge",
    },
    show_guides = true,
    filter_kind = false,
    icons = {
      Class = " ",
      Constructor = " ",
      Enum = " ",
      Function = " ",
      Interface = " ",
      Method = " ",
      Module = " ",
      Struct = " ",
      Variable = " ",
    },
    highlight_on_hover = true,
    autojump = true,
    manage_folds = false,
    link_folds_to_tree = false,
    link_tree_to_folds = true,
  },
  config = function(_, opts)
    require("aerial").setup(opts)

    -- 集成到 lualine
    local ok, lualine = pcall(require, "lualine")
    if ok then
      lualine.setup({
        sections = {
          lualine_x = { "aerial" },
        },
      })
    end
  end,
}
