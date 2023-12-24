return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			integrations = {
				notify = true,
			},
		},
		config = function(_, opts)
			vim.o.termguicolors = true
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
