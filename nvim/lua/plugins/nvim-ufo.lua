-- lua/plugins/nvim-ufo.lua
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
    close_fold_kinds_for_ft = {
      default = { "imports", "comment" },
    },
  },
  config = function(_, opts)
    require("ufo").setup(opts)
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "打开所有折叠" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "关闭所有折叠" })
  end,
}
