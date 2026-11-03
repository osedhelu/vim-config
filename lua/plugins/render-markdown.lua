return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "markdown.mdx" },
		opts = {
			-- "obsidian" da un look limpio con encabezados subrayados
			preset = "obsidian",
			heading = {
				sign = false,
				position = "inline",
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
				border = "thin",
			},
			bullet = {
				icons = { "●", "○", "◆", "◇" },
			},
			checkbox = {
				enabled = true,
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
			table = {
				enabled = true,
			},
			link = {
				enabled = true,
			},
			-- En insert mode se ve el texto crudo para escribir cómodo
			render_modes = { "n", "c", "t" },
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			-- <leader>um para activar/desactivar el render
			Snacks.toggle({
				name = "Render Markdown",
				get = require("render-markdown").get,
				set = require("render-markdown").set,
			}):map("<leader>um")
		end,
	},
}
