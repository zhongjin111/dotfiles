-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      rust = { "rustfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      java = { "google-java-format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  keys = {
    {
      "<leader>fm",
      function() require("conform").format({ async = true }) end,
      mode = "",
      desc = "格式化当前 buffer",
      --       desc = "[F]ormat buffer",
    },
  },
}
