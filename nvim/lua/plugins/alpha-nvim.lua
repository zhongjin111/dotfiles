return {
  "goolord/alpha-nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 先注册隐藏/恢复逻辑，确保能捕获到 alpha.setup 触发的 FileType 事件
    local alpha_augroup = vim.api.nvim_create_augroup("AlphaUI", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      group = alpha_augroup,
      callback = function()
        vim.opt.laststatus = 0
        vim.opt.showtabline = 0
      end,
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      group = alpha_augroup,
      callback = function()
        if vim.bo.filetype ~= "alpha" then
          if vim.opt.laststatus:get() == 0 then
            vim.opt.laststatus = 3
          end
          if vim.opt.showtabline:get() == 0 then
            vim.opt.showtabline = 2
          end
          vim.cmd("redraw!")
        end
      end,
    })

    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    dashboard.section.header.opts.hl = "AlphaHeader"

    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  查找文件", ":Telescope find_files<CR>"),
      dashboard.button("r", "󰋚  最近文件", ":Telescope oldfiles<CR>"),
      dashboard.button("g", "󰊄  全文搜索", ":Telescope live_grep<CR>"),
      dashboard.button("n", "󰈔  新建文件", ":ene <BAR> startinsert<CR>"),
      dashboard.button("e", "󰉋  文件管理", ":Neotree toggle<CR>"),
      dashboard.button("t", "󰆍  打开终端", ":ToggleTerm<CR>"),
      dashboard.button("G", "󰊢  Git 控制", ":Neogit<CR>"),
      dashboard.button("d", "󰅺  诊断信息", ":Trouble diagnostics toggle<CR>"),
      dashboard.button("p", "󰏗  插件管理", ":Lazy<CR>"),
      dashboard.button("c", "󰒓  编辑配置", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "󰈆  退出程序", ":qa<CR>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl             = "AlphaButton"
      button.opts.hl_shortcut    = "AlphaShortcut"
      button.opts.align_shortcut = "right"
      button.opts.width          = 30
    end

    local function build_footer()
      local week_map = { "日", "一", "二", "三", "四", "五", "六" }
      local w = week_map[tonumber(os.date("%w")) + 1]

      local hour = tonumber(os.date("%H"))
      local greet = (hour < 6 and "凌晨好")
          or (hour < 12 and "早上好")
          or (hour < 14 and "中午好")
          or (hour < 18 and "下午好")
          or "晚上好"

      local datetime = os.date("%Y年%m月%d日 星期" .. w .. " %H:%M:%S")
      local lines = { greet .. "，欢迎回来", datetime }

      local ok, lazy = pcall(require, "lazy")
      if ok then
        local s = lazy.stats() or {}
        local stime = tonumber(s.startuptime) or 0
        if stime > 0 then
          table.insert(lines, string.format("启动耗时 %.2f ms", stime))
        end
      end

      return lines
    end

    dashboard.section.footer.val = build_footer()
    dashboard.section.footer.opts.hl = "AlphaFooter"

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    dashboard.config.opts.margin = 6

    -- 把颜色设置封装成函数，方便 colorscheme 变化时重新应用
    local function apply_alpha_highlights()
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#33FF99", bold = true })
      vim.api.nvim_set_hl(0, "AlphaButton", { fg = "#F2F8F2" })
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#00FFFF", bold = true })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#66FF66", italic = true })
    end

    -- 首次应用
    apply_alpha_highlights()

    -- 每次 colorscheme 变化（比如 lualine、catppuccin 集成触发）都重新应用
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = alpha_augroup,
      callback = apply_alpha_highlights,
    })

    alpha.setup(dashboard.config)

    -- 双保险：setup 之后再强制隐藏一次，防止 lualine / bufferline 延迟加载覆盖
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0

    -- setup 之后重新应用一次高亮，防止被颜色方案覆盖
    apply_alpha_highlights()

    vim.defer_fn(function()
      dashboard.section.footer.val = build_footer()
      apply_alpha_highlights() -- 重绘前再应用一次
      pcall(function() alpha.redraw() end)
    end, 100)

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.keymap.set("n", "<Esc>", ":ene <BAR> startinsert<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "f", ":Telescope find_files<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "r", ":Telescope oldfiles<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
      end,
    })
  end,
}
