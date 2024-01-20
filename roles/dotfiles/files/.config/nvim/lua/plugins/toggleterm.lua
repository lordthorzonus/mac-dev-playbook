return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<leader>tt]],
				insert_mappings = false,
				close_on_exit = true, -- close the terminal window when the process exits
				hide_numbers = true, -- hide the number column in toggleterm buffers
				direction = "float",
				float_opts = {
					border = "rounded",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})
		end,
	},
}
