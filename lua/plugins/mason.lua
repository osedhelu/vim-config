return {
  "williamboman/mason-lspconfig.nvim",
  -- overrides `require("mason-lspconfig").setup(...)`
  opts = {
    ensure_installed = {
      "lua_ls",
      "jsonls",
      "vtsls",
      "pyright",
      -- No uses "tsserver" aquí: astrocommunity.pack.typescript ya usa solo vtsls.
      -- Tener tsserver + vtsls duplica el LSP y rompe signature help / posiciones.
    },
  },
}

--
-- return {
--   -- use mason-lspconfig to configure LSP installations
--
--   -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
--   {
--     "jay-babu/mason-null-ls.nvim",
--     -- overrides `require("mason-null-ls").setup(...)`
--     opts = {
--       ensure_installed = {
--         "stylua",
--         "python",
--       },
--     },
--   },
--   {
--     "jay-babu/mason-nvim-dap.nvim",
--     -- overrides `require("mason-nvim-dap").setup(...)`
--     opts = {
--       ensure_installed = {
--         "python",
--         -- add more arguments for adding more debuggers
--       },
--     },
--   },
-- }
