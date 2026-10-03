-- lua/plugins/nvim-treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc",
      "python", "javascript", "typescript", "tsx",
      "rust", "c", "cpp", "java", "go",
      "json", "yaml", "toml", "markdown", "markdown_inline",
      "bash", "dockerfile", "gitignore", "html", "css", "scss",
      "regex", "sql", "xml",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf = args.buf
        local ft = args.match
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then return end
        if vim.treesitter.language.add(lang) then
          pcall(vim.treesitter.start, buf, lang)
          local has_indent = vim.treesitter.query.get(lang, "indents") ~= nil
          if has_indent then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end
      end,
    })
  end,
}
