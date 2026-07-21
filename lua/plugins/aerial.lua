return {
  {
    "stevearc/aerial.nvim",
    opts = {
      -- default options
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
      -- Mostrar un indicador visual del bloque actual
      show_guides = true,
      -- Configurar la apariencia de los símbolos de markdown
      backends = { "treesitter", "markdown", "man" },
      layout = {
        min_width = 28,
        default_direction = "right",
      },
    },
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function(_, opts)
      require("aerial").setup(opts)

      -- Crear un autocomando para abrir automáticamente Aerial al abrir un archivo Markdown (.md)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- Abrir Aerial pero sin mover el foco del cursor del archivo principal
          require("aerial").open({ focus = false })
        end,
      })
    end,
    -- Teclas de acceso rápido para alternar la vista manualmente si se desea
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Estructura / Outline" },
      { "<F9>", "<cmd>AerialToggle!<cr>", desc = "Estructura / Outline" },
    },
  }
}
