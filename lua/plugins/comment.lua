return {
  "numToStr/Comment.nvim",
  opts = function(_, opts)
    -- ts_context_commentstring lanza un error en archivos sin parser de treesitter
    -- (p. ej. .env), en vez de devolver fallback al commentstring nativo.
    -- Envolvemos el pre_hook para degradar con gracia: si falla (o no decide),
    -- comentar con el commentstring del buffer.
    local pre_hook = opts.pre_hook
    opts.pre_hook = function(...)
      local ok, result = pcall(pre_hook, ...)
      if ok and result then
        return result
      end
      local cs = vim.bo.commentstring
      if cs and cs ~= "" then
        return cs
      end
      return nil
    end
  end,
}