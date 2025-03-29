local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

function M.config()
  local servers = {
    "lua_ls",
    "cssls",
    "html",
    "eslint",
    "tailwindcss",
    "ts_ls",
    "pyright",
    "ruff",
    "taplo",
    "bashls",
    "jsonls",
    "jdtls",
    "yamlls",
    "clangd",
    "denols",
    "gopls",
  }

  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })

  require("mason-lspconfig").setup({
    ensure_installed = servers,
  })
end

return M
