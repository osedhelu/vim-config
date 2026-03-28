return {
  "AstroNvim/astrolsp",
  -- we must use the function override because table merging
  -- does not play nicely with list-like tables
  ---@param opts AstroLSPOpts
  opts = function(plugin, opts)
    -- safely extend the servers list
    opts.servers = opts.servers or {}
    vim.list_extend(opts.servers, {
      "pyright",
      -- add more servers as needed...
    })

    -- Pyright solo puede resolver imports (p. ej. django) si ve el mismo Python/venv
    -- que usas en el proyecto. Si falla, crea pyrightconfig.json en la raíz del repo
    -- con: "venv": ".venv" (o el nombre de tu carpeta de entorno virtual).
    --
    -- ESLint LSP viene de astrocommunity.pack.typescript. Si ves -32603 / "textDocument/diagnostic failed",
    -- el fallo es casi siempre del eslint o node_modules del *proyecto* (no de Neovim).
    -- Para apagar solo el cliente ESLint y dejar vtsls (defs, tipos): en init.lua antes de lazy:
    --   vim.g.disable_eslint_lsp = true
    local extra = {
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      },
    }
    if vim.g.disable_eslint_lsp then
      extra.eslint = false
    else
      extra.eslint = {
        settings = {
          -- Monorepos / apps en subcarpeta: ayuda a que encuentre el eslint correcto
          workingDirectory = { mode = "auto" },
        },
      }
    end
    opts.config = require("astrocore").extend_tbl(opts.config or {}, extra)
  end,
}
