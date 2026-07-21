return {
  "nvimtools/none-ls.nvim",
  -- Neovim 0.12+: _request_name_to_capability fue eliminado; requiere e057efc+
  commit = "e057efcb97c3d06a64739a9cc2acc18c0acdb894",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    -- Black vía uv tool (~/.local/bin). Mason falla sin python3-venv.
    local black_cmd = vim.fn.exepath "black"
    if black_cmd == "" then
      local fallback = vim.fn.expand "~/.local/bin/black"
      if vim.fn.executable(fallback) == 1 then black_cmd = fallback end
    end

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.black.with {
        command = black_cmd ~= "" and black_cmd or "black",
        extra_args = { "--quiet" },
      },
    })
  end,
}
