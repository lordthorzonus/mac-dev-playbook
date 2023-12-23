return {
	{
		"echasnovski/mini.move",
		version = false,
		config = function()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					left = "<S-Left>",
					right = "<S-Right>",
					down = "<S-Down>",
					up = "<S-Up>",

					line_left = "",
					line_right = "",
					line_down = "",
					line_up = "",
					-- Move current line in Normal mode
				},
			})
		end,
	},
}
