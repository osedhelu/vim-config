-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Guardar el archivo actual (<leader>w antes era el grupo de ventanas)
vim.keymap.set({ "n", "x" }, "<leader>w", "<cmd>w<cr>", { desc = "Guardar archivo" })

-- Ventanas: todo lo que antes estaba en <leader>w ahora vive en <leader>0
-- Quitar los atajos antiguos para que <leader>w guarde de inmediato
pcall(vim.keymap.del, "n", "<leader>wd")
pcall(vim.keymap.del, "n", "<leader>wm")

-- Cerrar la ventana actual
vim.keymap.set("n", "<leader>0d", "<C-W>c", { desc = "Cerrar ventana", remap = true })

-- Maximizar/restaurar la ventana actual (zoom)
local ok_snacks, snacks = pcall(require, "snacks")
if ok_snacks then
  snacks.toggle.zoom():map("<leader>0m")
end

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
vim.keymap.set("n", "<leader>x", "<cmd>qa<cr>", { desc = "Salir de Neovim" })

-- Comentar/descomentar con <leader>/
-- Eliminar los atajos de comentarios existentes (gcc, gc, gcO, gco)
for _, spec in ipairs({
  { "n", "gcc" },
  { "n", "gc" },
  { "n", "gcO" },
  { "n", "gco" },
  { "x", "gc" },
  { "o", "gc" },
}) do
  pcall(vim.keymap.del, spec[1], spec[2])
end

pcall(vim.keymap.del, "n", "<leader>/")
pcall(vim.keymap.del, "x", "<leader>/")

-- Línea actual (normal)
vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comentar/descomentar línea" })

-- Selección (visual)
vim.keymap.set("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", {
  desc = "Comentar/descomentar selección",
})

-- Formatear el buffer usando el formateador que corresponda al filetype
-- (conform.nvim y, si no hay, el formateador del LSP)
vim.keymap.set({ "n", "x" }, "ga", function()
  LazyVim.format({ force = true })
end, { desc = "Formatear código" })
