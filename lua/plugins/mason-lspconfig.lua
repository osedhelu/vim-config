return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "tsserver", "eslint", "sumneko_lua" },
    },
  },
}
