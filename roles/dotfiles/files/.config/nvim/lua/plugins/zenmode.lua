return {
	{
		"Subjective/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
                window = {
                    zindex = 20,
                    width = 120,
                    options = {},
                },
                plugins = {
					tmux = { enabled = true },
				},
			})

			vim.keymap.set("n", "<leader>zz", function()
				require("zen-mode").toggle()
			end)
		end,
	},
}
