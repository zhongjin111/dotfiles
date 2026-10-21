return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1001,
  opts = {
    flavour = "mocha", -- 可选: latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    lsp_styles = {
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
        ok = { "underline" },
      },
      inlay_hints = { background = true },
    },
    color_overrides = {},
    custom_highlights = {},
    auto_integrations = true, -- 自动检测已安装插件并启用集成
    integrations = {
      -- 针对你已安装的插件
      alpha = true,
      blink_cmp = { style = "bordered" },
      gitsigns = true,
      telescope = { enabled = true },
      notify = false,
      noice = false,
      which_key = true,
      lualine = true,
      -- bufferline 需要特殊处理，见下文
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
