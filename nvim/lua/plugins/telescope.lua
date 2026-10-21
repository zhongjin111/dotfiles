return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		-- 加载 fzf 扩展（你之前漏了这一步，顺便补上）
		pcall(telescope.load_extension, "fzf")
		-- 加载内置的 jump 扩展
		pcall(telescope.load_extension, "jump")

		-- 键位映射
		vim.keymap.set("n", "<leader>fj", ":Telescope jump<CR>", { desc = "跳转历史" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "查找文件" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "全文搜索" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "缓冲区" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "最近文件" })
		vim.keymap.set("n", "<leader>fw", function()
			require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
		end, { desc = "搜索光标下的词" })
	end,
}
