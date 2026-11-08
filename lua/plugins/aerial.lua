-- aerial.nvim: AstroNvim fija ^2.x, pero Neovim 0.12 necesita >=4.0
-- (node:start() eliminado → crash en helpers.lua). Forzamos la rama actual.
return {
  {
    "stevearc/aerial.nvim",
    version = false, -- ignorar pin ^2.2 de AstroNvim
    opts = {
      -- Preferir LSP; treesitter como respaldo (más estable en nvim 0.12)
      backends = { "lsp", "treesitter", "markdown", "man" },
      show_guides = true,
      layout = {
        min_width = 28,
        default_direction = "right",
      },
    },
    config = function(_, opts)
      require("aerial").setup(opts)

      -- Outline automático en Markdown (sin robar el foco)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          pcall(function()
            require("aerial").open { focus = false }
          end)
        end,
      })
    end,
    keys = {
      { "<Leader>o", "<Cmd>AerialToggle!<CR>", desc = "Estructura / Outline" },
      { "<F9>", "<Cmd>AerialToggle!<CR>", desc = "Estructura / Outline" },
    },
  },
}
