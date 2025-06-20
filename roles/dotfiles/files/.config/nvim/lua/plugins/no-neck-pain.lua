return {
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		config = function()
			require("no-neck-pain").setup({
				width = 120,
				buffers = {
					colors = {
						backroundColor = "catppuccin-mocha-dark",
					},
					scratchPad = {
						enabled = false,
						fileName = "notes",
						location = "~/",
					},
				},
			})

			vim.keymap.set("n", "<leader>zz", function()
				vim.cmd("NoNeckPain")
			end)
		end,
	},
}
