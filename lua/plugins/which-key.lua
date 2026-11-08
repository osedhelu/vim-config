return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.spec = opts.spec or {}

    -- El grupo de ventanas se mueve de <leader>w a <leader>0
    table.insert(opts.spec, {
      "<leader>0",
      group = "windows",
      proxy = "<c-w>",
      mode = { "n", "x" },
      expand = function()
        return require("which-key.extras").expand.win()
      end,
    })

    -- <leader>w ahora es una acción (guardar), no un grupo
    table.insert(opts.spec, { "<leader>w", desc = "Guardar archivo", mode = { "n", "x" } })

    -- <leader>x cierra el editor (antes era el grupo diagnostics/quickfix)
    table.insert(opts.spec, { "<leader>x", desc = "Salir de Neovim", mode = { "n" } })
  end,
}
