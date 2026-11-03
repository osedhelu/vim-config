-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Close current buffer, prompting to save if there are unsaved changes
vim.keymap.set("n", "<leader>qx", function()
  local ok, snacks = pcall(require, "snacks")
  if ok then
    snacks.bufdelete()
  else
    vim.cmd("bdelete")
  end
end, { desc = "Cerrar buffer actual" })
