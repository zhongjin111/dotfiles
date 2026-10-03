-- lua/plugins/mason-nvim-dap.lua
return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  opts = {
    ensure_installed = { "codelldb", "debugpy", "delve" },
    automatic_installation = true,
  },
}
