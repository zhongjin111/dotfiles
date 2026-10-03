return {
  "goolord/alpha-nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

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
      dashboard.button("f", "» 查找文件 «", ":Telescope find_files<CR>"),
      dashboard.button("r", "» 最近文件 «", ":Telescope oldfiles<CR>"),
      dashboard.button("g", "» 全文搜索 «", ":Telescope live_grep<CR>"),
      dashboard.button("n", "» 新建文件 «", ":ene <BAR> startinsert<CR>"),
      dashboard.button("e", "» 文件管理 «", ":Neotree toggle<CR>"),
      dashboard.button("t", "» 打开终端 «", ":ToggleTerm<CR>"),
      dashboard.button("G", "» Git 控制 «", ":Neogit<CR>"),
      dashboard.button("d", "» 诊断信息 «", ":Trouble diagnostics toggle<CR>"),
      dashboard.button("p", "» 插件管理 «", ":Lazy<CR>"),
      dashboard.button("c", "» 编辑配置 «", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "» 退出程序 «", ":qa<CR>"),
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
      local greet = (hour < 6  and "凌晨好")
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

    vim.api.nvim_set_hl(0, "AlphaHeader",   { fg = "#33FF99", bold = true })
    vim.api.nvim_set_hl(0, "AlphaButton",   { fg = "#F2F8F2" })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#00FFFF", bold = true })
    vim.api.nvim_set_hl(0, "AlphaFooter",   { fg = "#66FF66", italic = true })

    alpha.setup(dashboard.config)

    vim.defer_fn(function()
      dashboard.section.footer.val = build_footer()
      pcall(function() alpha.redraw() end)
    end, 100)

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.keymap.set("n", "<Esc>", ":ene <BAR> startinsert<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "f",     ":Telescope find_files<CR>",  { buffer = true, silent = true })
        vim.keymap.set("n", "r",     ":Telescope oldfiles<CR>",    { buffer = true, silent = true })
        vim.keymap.set("n", "q",     ":qa<CR>",                    { buffer = true, silent = true })
      end,
    })
  end,
}
