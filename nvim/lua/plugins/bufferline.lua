return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "neo-tree",
          text = "文件管理",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
    end

    map("<leader>bj", "<cmd>BufferLineCycleNext<cr>", "下一个 buffer")
    map("<leader>bk", "<cmd>BufferLineCyclePrev<cr>", "上一个 buffer")
    map("<leader>bd", "<cmd>bdelete<cr>", "关闭当前 buffer")
    map("<leader>bh", "<cmd>BufferLineCloseLeft<cr>", "关闭左侧 buffer")
    map("<leader>bl", "<cmd>BufferLineCloseRight<cr>", "关闭右侧 buffer")
    map("<leader>bo", "<cmd>BufferLineCloseOthers<cr>", "关闭其他 buffer")
    map("<leader>bf", "<cmd>BufferLinePick<cr>", "选择 buffer 跳转")
    map("<leader>bp", "<cmd>BufferLineTogglePin<cr>", "固定/取消固定 buffer")
    map("<leader>bH", "<cmd>BufferLineMovePrev<cr>", "buffer 左移")
    map("<leader>bL", "<cmd>BufferLineMoveNext<cr>", "buffer 右移")

    for i = 1, 9 do
      map("<leader>b" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", "跳到 buffer " .. i)
    end
    map("<leader>b0", "<cmd>BufferLineGoToBuffer 10<cr>", "跳到 buffer 10")
  end,
}
