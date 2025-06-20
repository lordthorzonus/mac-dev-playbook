return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		enable = false,
		opts = {
			breadcrumbs = {
				enable = false,
			},
			outline = {
				layout = "float",
				keys = {
					jump = "e",
					toggle_or_jump = "<cr>",
					quit = "<esc>",
				},
				detail = false,
			},
			lightbulb = {
				enable = false,
				sign = false,
				enable_in_insert = false,
			},
			callhierarchy = {
				keys = {
					quit = "<esc>",
				},
			},
			symbol_in_winbar = {
				enable = false,
			},
			rename = {
				enable = true,
				keymaps = {
					quit = "<esc>",
				},
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function(_, opts)
			local lspsaga = require("lspsaga")
			lspsaga.setup(opts)

			vim.keymap.set("n", "<leader>vrn", function()
				vim.cmd("Lspsaga rename")
			end)
		end,
	},
}
