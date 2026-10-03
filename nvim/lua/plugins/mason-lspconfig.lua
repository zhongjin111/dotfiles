-- lua/plugins/mason-lspconfig.lua
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "lua_ls", "clangd", "jdtls", "rust_analyzer", "pyright",
      "gopls", "ts_ls", "html", "cssls", "jsonls", "yamlls", "bashls",
    },
    automatic_installation = true,
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)

    local ok, blink = pcall(require, "blink.cmp")
    local capabilities = ok and blink.get_lsp_capabilities()
        or vim.lsp.protocol.make_client_capabilities()

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    for _, server in ipairs(opts.ensure_installed) do
      if server ~= "lua_ls" then
        vim.lsp.config(server, { capabilities = capabilities })
      end
    end

    vim.lsp.enable(opts.ensure_installed)

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.buf
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "跳转定义")
        map("gD", vim.lsp.buf.declaration, "跳转声明")
        map("gi", vim.lsp.buf.implementation, "跳转实现")
        map("gr", vim.lsp.buf.references, "查看引用")
        map("K", vim.lsp.buf.hover, "悬停文档")
        map("<leader>rn", vim.lsp.buf.rename, "重命名")
        map("<leader>ca", vim.lsp.buf.code_action, "代码动作")
        map("[d", vim.diagnostic.goto_prev, "上一个诊断")
        map("]d", vim.diagnostic.goto_next, "下一个诊断")
      end,
    })
  end,
}
