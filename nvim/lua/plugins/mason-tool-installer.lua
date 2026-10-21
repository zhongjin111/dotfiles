-- lua/plugins/mason-tool-installer.lua
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = {
      "stylua", "ruff", "prettierd", "eslint_d", "clang-format",
      "google-java-format", "gofumpt", "goimports",
    },
    auto_update = true,
    run_on_start = false,
    --     start_delay = 3000,
  },
}
