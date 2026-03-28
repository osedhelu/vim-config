--- Una sola definición: AstroCore + reaplicar tras EasyMotion
local M = {}

function M.for_astrocore()
  local virtual_text = { spacing = 2, source = "if_many" }
  if vim.fn.has "nvim-0.11" == 1 then virtual_text.current_line = true end
  return {
    virtual_text = virtual_text,
    virtual_lines = false,
    underline = true,
    update_in_insert = false,
  }
end

function M.apply_vim_diagnostic()
  local d = M.for_astrocore()
  vim.diagnostic.config(vim.tbl_extend("force", d, {
    severity_sort = true,
    float = { border = "rounded", source = true },
  }))
end

return M
