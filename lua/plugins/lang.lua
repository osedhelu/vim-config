-- Soporte de lenguajes: Python (uv), Flutter/Dart, Kotlin y Node.js.
--
-- Los extras de LazyVim se activan en lazyvim.json. Acá sólo van los ajustes
-- que los extras no cubren (venv de uv, formateo con ruff, PATH de fvm, etc.).

-- Flutter vía fvm: si nvim se abrió desde el Finder/GUI el PATH puede no
-- incluir el SDK y dartls no arranca. Lo agregamos de forma idempotente.
do
	local fvm_bin = vim.fn.expand("~/fvm/default/bin")
	local path = vim.env.PATH or ""
	if vim.fn.isdirectory(fvm_bin) == 1 and not path:find(fvm_bin, 1, true) then
		vim.env.PATH = fvm_bin .. ":" .. path
	end
end

-- Kotlin: kotlin-language-server 1.3.x está compilado para Java 21, pero el
-- JAVA_HOME global apunta a Java 17. Si el JDK 21 de Homebrew existe, se lo
-- pasamos sólo a este LSP. En Linux/otras máquinas no se toca nada.
local kotlin_env = {}
local jdk21 = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
if vim.fn.isdirectory(jdk21) == 1 then
	kotlin_env.JAVA_HOME = jdk21
end

return {
	-- Python: pyright tiene que encontrar el .venv que crea `uv sync`.
	-- uv usa siempre <proyecto>/.venv, así que con venvPath = "." alcanza.
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {
						python = {
							venvPath = ".",
							venv = ".venv",
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},
				-- El server se instala con `brew install kotlin-language-server`
				-- (no está en el registro de mason). mason = false hace que
				-- LazyVim lo habilite con vim.lsp.enable en vez de esperar a
				-- mason-lspconfig, que nunca lo activaría.
				kotlin_language_server = {
					mason = false,
					cmd_env = kotlin_env,
				},
			},
		},
	},

	-- Python: lint + formato con ruff (ordena imports, aplica fixes y formatea).
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
			},
		},
	},

	-- Herramientas que no instalan los extras.
	-- ruff: lo usa conform para formatear Python (el LSP ruff lo instala
	-- mason-lspconfig solo). Ojo: `fd` NO existe como paquete de mason; se
	-- instala con `brew install fd` (lo necesita venv-selector, <leader>cv).
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = { "ruff" },
		},
	},
}
