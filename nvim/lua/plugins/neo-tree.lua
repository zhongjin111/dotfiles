-- lua/plugins/neo-tree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "Crysthamus/nvim-file-operations",
  },
  lazy = false,
  opts = {
    filesystem = { follow_current_file = { enabled = true } },
    window = { width = 30 },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- 只有无参数启动时才自动打开，避免打开文件时被干扰
        if vim.fn.argc() ~= 0 then return end

        -- 延时一会儿，等 alpha 完全渲染完成
        vim.defer_fn(function()
          local alpha_win = vim.api.nvim_get_current_win()

          -- 打开侧边栏（会创建新窗口并抢焦点）
          vim.cmd("Neotree show")

          -- 焦点切回 alpha 窗口
          if vim.api.nvim_win_is_valid(alpha_win) then
            vim.api.nvim_set_current_win(alpha_win)
          end
        end, 50)
      end,
    })
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "文件管理" },
  },
}
