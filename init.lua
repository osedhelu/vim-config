local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- uv tool install (black, ruff, …) vive en ~/.local/bin; GUIs a veces no lo tienen en PATH
do
  local local_bin = vim.fn.expand "~/.local/bin"
  if not vim.env.PATH:find(local_bin, 1, true) then
    vim.env.PATH = local_bin .. ":" .. vim.env.PATH
  end
end

-- Si el LSP de ESLint falla en tus proyectos (error -32603 / diagnostic failed), descomenta:
-- vim.g.disable_eslint_lsp = true

if not pcall(require, "lazy") then
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true,
    {}
  )
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
