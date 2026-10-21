-- ~/.config/nvim/lua/config/settings.lua

-- 基础设置
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.neovide_opacity = 0.7
vim.g.neovide_normal_opacity = 0.7
vim.g.neovide_scale_factor = 0.95
vim.opt.winblend = 20
vim.opt.pumblend = 20
vim.opt.whichwrap:append("h,l,<,>,[,]")
vim.opt.fillchars = { eob = " " }

-- 行号颜色设置
local function set_line_number_colors()
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#66CC66", bold = true })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#66CCCC", bold = true })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#66CC99", bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#66CC99", bold = true })
end
set_line_number_colors()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_line_number_colors,
})

-- 界面显示与响应
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 150 -- 【优化】从 250 改为 150，响应更快
vim.opt.timeoutlen = 150 -- 快捷键触发更干脆
vim.opt.scrolloff = 10 -- 【优化】从 8 改为 10，保持光标上下居中
vim.opt.equalalways = false -- 分割窗口时更自然，不强制等宽等高

-- 缩进与编辑
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- 搜索设置
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true -- 【新增】搜索时高亮所有匹配项
vim.opt.incsearch = true -- 【新增】输入搜索词时实时高亮
vim.opt.shortmess:append("c") -- 搜索到末尾时不显示 "search hit BOTTOM"

-- 窗口与鼠标
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.cursorline = true

-- 诊断提示
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = { border = "rounded", source = true },
})

-- Treesitter 原生高亮与折叠
vim.treesitter.start = vim.treesitter.start or function() end
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- 【注意】新版 nvim-treesitter-textobjects 模块路径修复
-- 如果这里报错 "module not found"，请确保你安装了 nvim-treesitter-textobjects
-- local ok, ts = pcall(require, "nvim-treesitter-textobjects.select")
-- if ok then
-- 	vim.keymap.set({ "x", "o" }, "af", function()
-- 		ts.select_textobject("@function.outer", "textobjects")
-- 	end)
-- 	vim.keymap.set({ "x", "o" }, "if", function()
-- 		ts.select_textobject("@function.inner", "textobjects")
-- 	end)
-- 	vim.keymap.set({ "x", "o" }, "ac", function()
-- 		ts.select_textobject("@class.outer", "textobjects")
-- 	end)
-- 	vim.keymap.set({ "x", "o" }, "ic", function()
-- 		ts.select_textobject("@class.inner", "textobjects")
-- 	end)
-- else
-- 	-- 兼容旧版 require 方式
-- 	local ts_old = pcall(require, "nvim-treesitter-textobjects")
-- 	if ts_old then
-- 		-- 旧版写法这里不报错的话可以忽略
-- 	end
-- end

-- 复制/粘贴时的高亮提示
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- 让 jk 快速退出插入模式
vim.keymap.set("i", "jk", "<Esc>", { desc = "退出插入模式" })

vim.keymap.set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p") -- 绝对路径
	vim.fn.setreg("+", path)
	print("已复制绝对路径: " .. path)
end, { desc = "复制文件绝对路径" })

vim.keymap.set("n", "<leader>yr", function()
	local path = vim.fn.expand("%:.") -- 相对路径 (相对当前 nvim 目录)
	vim.fn.setreg("+", path)
	print("已复制相对路径: " .. path)
end, { desc = "复制文件相对路径" })

-- 结合 mini.ai 或者原生操作
-- local ts = require("nvim-treesitter-textobjects")
-- vim.keymap.set({ "x", "o" }, "af", function()
-- 	ts.select_textobject("@function.outer")
-- end, { desc = "选择整个函数" })
-- vim.keymap.set({ "x", "o" }, "if", function()
-- 	ts.select_textobject("@function.inner")
-- end, { desc = "选择函数内部" })
-- vim.keymap.set({ "x", "o" }, "aa", function()
-- 	ts.select_textobject("@parameter.outer")
-- end, { desc = "选择整个参数" })
-- vim.keymap.set({ "x", "o" }, "ia", function()
-- 	ts.select_textobject("@parameter.inner")
-- end, { desc = "选择参数内部" })
