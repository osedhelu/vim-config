return {
  "nvimtools/none-ls.nvim",
  -- Neovim 0.12+: _request_name_to_capability fue eliminado; requiere e057efc+
  commit = "e057efcb97c3d06a64739a9cc2acc18c0acdb894",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.black.with {
        extra_args = { "--quiet" },
      },
    })
  end,
}
