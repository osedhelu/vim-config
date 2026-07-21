return {
  "jay-babu/mason-null-ls.nvim",
  optional = true,
  opts = function(_, opts)
    -- Black/ruff: instalar con `uv tool install black` (Mason necesita python3-venv)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
      "stylua",
    })
    return opts
  end,
}
