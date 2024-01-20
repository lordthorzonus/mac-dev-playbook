return {
	{
		"stevearc/aerial.nvim",
		opts = {
			layout = {
				min_width = 0.5,
			},
			keymaps = {
				["<C-n>"] = "actions.down_and_scroll",
				["<C-p>"] = "actions.up_and_scroll",
				["<esc>"] = "actions.close",
			},
			float = {
				relative = "editor",
				min_height = 0.5,
			},
			show_guides = true,
		},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function(_, opts)
			require("aerial").setup(opts)

			vim.keymap.set("n", "<c-s>", function()
				vim.cmd("AerialToggle float")
			end, {})
		end,
	},
}
