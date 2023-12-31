return {
	{
		"nvim-lualine/lualine.nvim",
		version = false,
		opts = {
			options = {
				theme = "auto",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_x = { "tabs" },
				lualine_y = { "progress" },
				lualine_z = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic", "nvim_lsp" },
						sections = { "error", "warn", "info", "hint" },
						diagnostics_color = {
							error = "DiagnosticError",
							warn = "DiagnosticWarn",
							info = "DiagnosticInfo",
							hint = "DiagnosticHint",
						},
						symbols = { error = "E", warn = "W", info = "I", hint = "H" },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					},
				},
			},
		},
	},
}
