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
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
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
    })
  end,
}
