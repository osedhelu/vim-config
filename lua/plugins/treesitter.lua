return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- Evita varias descargas/compilaciones en paralelo (menos "mkdir: File exists" en tmp).
    sync_install = true,
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "bash",
      "python",
      "rust",
      "typescript",
      "javascript",
      "tsx",
      "html",
      "css",
      "scss",
    },
    highlight = {
      enable = true,
    },
  },
}
