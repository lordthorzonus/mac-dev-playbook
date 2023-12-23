return {
	{
		"tpope/vim-fugitive",
		version = false,
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
}
