vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.neovide_opacity = 0.7
vim.g.neovide_normal_opacity = 0.7
vim.opt.winblend = 20
vim.opt.pumblend = 20
-- vim.api.nvim_create_autocmd({ "UIEnter", "VimEnter" }, {
--   callback = function()
--    vim.opt.number = true
--    vim.opt.relativenumber = true
--  end,
-- })
-- ~/.config/nvim/lua/config/settings.lua
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
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.cursorline = true

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})
-- 启用 Neovim 原生的 treesitter 高亮（Neovim 0.12+ 必需）
vim.treesitter.start = vim.treesitter.start or function() end

-- 如果使用 Neovim 0.12+，建议启用以下选项以获得更好的 treesitter 体验
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
