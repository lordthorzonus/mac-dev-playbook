return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<leader>tt]],
			    insert_mappings = false,
			})
		end,
	},
}
