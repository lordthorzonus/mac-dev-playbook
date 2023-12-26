return {
	{
		"MunifTanjim/prettier.nvim",
		version = false,
		event = "LspAttach",
		opts = {
			bin = "prettier",
			filetypes = {
				"css",
				"graphql",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"less",
				"markdown",
				"scss",
				"typescript",
				"typescriptreact",
				"yaml",
			},
		},
	},
}
