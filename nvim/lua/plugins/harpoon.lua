-- lua/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- 添加当前文件到书签
    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
      print("已添加当前文件到 Harpoon")
    end, { desc = "添加当前文件到书签" })

    -- 打开/关闭书签菜单
    vim.keymap.set("n", "<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "打开书签菜单" })

    -- 快速跳转到第 1~9 个书签
    for i = 1, 9 do
      vim.keymap.set("n", "<leader>h" .. i, function()
        harpoon:list():select(i)
      end, { desc = "跳转书签 " .. i })
    end

    -- 顺手加两个按顺序切书签的快捷键
    vim.keymap.set("n", "<leader>hn", function()
      harpoon:list():next()
    end, { desc = "下一个书签" })

    vim.keymap.set("n", "<leader>hp", function()
      harpoon:list():prev()
    end, { desc = "上一个书签" })

    -- 注册 which-key 分组
    require("which-key").add({ { "<leader>h", group = "Harpoon 书签" } })
  end,
}
