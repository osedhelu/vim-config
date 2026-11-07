return {
	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		-- Reemplaza el <leader>e por defecto del extra (solo toggle)
		{ "<leader>e", false },
		{
			"<leader>e",
			function()
				if vim.bo.filetype == "neo-tree" then
					-- Ya estás en el árbol: vuelve a la ventana anterior
					vim.cmd.wincmd("p")
				else
					-- Abre/enfoca el explorador y mueve el cursor a él
					vim.cmd("Neotree focus")
				end
			end,
			desc = "Toggle Explorer Focus",
		},
		-- Toggle puro (abre/cierra sin mover el foco)
		{
			"<leader>o",
			"<Cmd>Neotree toggle<CR>",
			desc = "Toggle Explorer",
		},
	},
}
