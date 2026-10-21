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

    -- 计算「应该打开的根目录」
    -- 优先级：当前 buffer 路径 → nvim cwd → home
    local function resolve_root()
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname ~= "" then
        local ok, stat = pcall(vim.loop.fs_stat, bufname)
        if ok and stat then
          if stat.type == "directory" then
            return bufname
          else
            return vim.fn.fnamemodify(bufname, ":p:h")
          end
        end
      end

      local cwd = vim.fn.getcwd()
      if cwd and cwd ~= "" then
        return cwd
      end

      return vim.fn.expand("~")
    end

    -- 封装打开 Neotree 的逻辑
    local function open_neotree()
      -- 记住当前窗口（真实文件窗口）
      local origin_win = vim.api.nvim_get_current_win()
      local root = resolve_root()

      -- 同步 nvim 的 cwd，让 Telescope / LSP / 新建文件都基于项目目录
      vim.cmd.cd(vim.fn.fnameescape(root))

      -- 显式把 dir 传给 Neotree，绕过任何缓存的 cwd
      local cmd = "Neotree show left dir=" .. vim.fn.fnameescape(root)
      pcall(vim.cmd, cmd)

      -- 把焦点还回去，避免被文件树抢走
      if vim.api.nvim_win_is_valid(origin_win) then
        vim.api.nvim_set_current_win(origin_win)
      end
    end

    -- 1. 启动时：如果是 alpha 界面，直接跳过，保持居中
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.defer_fn(function()
          if vim.bo.filetype == "alpha" then
            return
          end
          open_neotree()
        end, 60)
      end,
    })

    -- 2. 从 alpha 进入真实文件后，自动打开一次 Neotree
    local opened_from_alpha = false
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        -- 已经自动打开过，或者当前还是 alpha 界面，或者没有文件名，直接跳过
        if opened_from_alpha or vim.bo.filetype == "alpha" or vim.api.nvim_buf_get_name(0) == "" then
          return
        end

        opened_from_alpha = true
        vim.defer_fn(function()
          open_neotree()
        end, 50)
      end,
    })
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "文件管理" },
  },
}
