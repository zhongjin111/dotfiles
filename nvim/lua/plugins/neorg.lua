-- lua/plugins/neorg.lua
return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {}, -- 隐藏标记符号，UI 更漂亮
				["core.dirman"] = {
					config = { workspaces = { notes = "~/notes" } },
				},
			},
		})
	end,
}
