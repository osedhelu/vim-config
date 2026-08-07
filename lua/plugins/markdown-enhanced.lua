---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= nil then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },
}
