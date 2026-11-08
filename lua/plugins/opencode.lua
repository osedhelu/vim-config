-- Integración con OpenCode (https://opencode.ai) desde Neovim.
--
-- La API actual de opencode.nvim es: ask(), select(), prompt(), operator() y
-- command(). No existe `opencode.send()`; `prompt()` además exige un string de
-- prompt, así que `opencode.prompt()` sin argumentos falla.
--
-- Contextos disponibles: @this, @buffer, @buffers, @diagnostics, @marks,
-- @quickfix, @visible.
return {
	"nickjvandyke/opencode.nvim",
	dependencies = {
		"folke/snacks.nvim", -- mejora ask() (input) y select() (picker)
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Por defecto opencode.nvim encuentra el server si ya tenés `opencode`
			-- corriendo; si no, lo arranca en un vsplit.
		}

		local opencode = function()
			return require("opencode")
		end

		-- Preguntar a OpenCode con el contexto del cursor/selección.
		-- En modo visual usa el rango seleccionado; en normal, la línea del cursor.
		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			opencode().ask("@this: ")
		end, { desc = "OpenCode: preguntar con contexto" })

		-- Menú de acciones sobre el código actual: explicar, revisar, corregir,
		-- documentar, optimizar, tests...
		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			opencode().select()
		end, { desc = "OpenCode: menú (explicar/revisar/fix)" })

		-- Enviar el rango seleccionado como prompt (se envía directo, sin diálogo).
		vim.keymap.set({ "n", "x" }, "<leader>ot", function()
			opencode().prompt("@this: ")
		end, { desc = "OpenCode: enviar selección al prompt" })

		-- Abrir/cerrar la terminal integrada de OpenCode.
		vim.keymap.set({ "n", "t" }, "<leader>oc", function()
			require("snacks.terminal").toggle("opencode", {
				win = { position = "right", enter = false },
			})
		end, { desc = "OpenCode: terminal" })
	end,
}
