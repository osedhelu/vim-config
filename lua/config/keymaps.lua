-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Cerrar el buffer actual
vim.keymap.set("n", "<leader>qq", function()
  local ok, snacks = pcall(require, "snacks")
  if ok then
    snacks.bufdelete()
  else
    vim.cmd("bdelete")
  end
end, { desc = "Cerrar buffer actual" })

-- Salir de Neovim
vim.keymap.set("n", "<leader>qx", "<cmd>qa<cr>", { desc = "Salir de Neovim" })

-- Formatear el buffer usando el formateador que corresponda al filetype
-- (conform.nvim y, si no hay, el formateador del LSP)
vim.keymap.set({ "n", "x" }, "ga", function()
  LazyVim.format({ force = true })
end, { desc = "Formatear código" })
