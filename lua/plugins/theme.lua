-- Tema actual.
--
-- En Omarchy (Linux) este archivo era un symlink a
-- ~/.local/state/omarchy/current/theme/neovim.lua, que Omarchy regenera cada vez
-- que se cambia de tema. En una máquina sin Omarchy (macOS) ese destino no
-- existe, el symlink queda roto y lazy falla al importar `plugins.theme`,
-- impidiendo que Neovim arranque.
--
-- Ahora se carga el tema de Omarchy solo si existe y, si no, se usa un
-- colorscheme seguro que siempre está instalado.

local omarchy_theme = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

if vim.fn.filereadable(omarchy_theme) == 1 then
	local ok, spec = pcall(dofile, omarchy_theme)
	if ok and type(spec) == "table" then
		return spec
	end
	vim.notify("No se pudo cargar el tema de Omarchy, usando tokyonight:\n" .. tostring(spec), vim.log.levels.WARN)
end

return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight",
		},
	},
}
