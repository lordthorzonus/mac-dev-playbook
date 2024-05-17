return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			integrations = {
				notify = true,
				aerial = true,
				cmp = true,
				gitsigns = true,
				lsp_trouble = true,
				mini = true,
				neotest = true,
				noice = true,
				treesitter = true,
				treesitter_context = true,
				telescope = true,
				indent_blankline = { enabled = true },
			},
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
				inlay_hints = {
					background = true,
				},
			},
		},

		config = function(_, opts)
			vim.o.termguicolors = true
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
