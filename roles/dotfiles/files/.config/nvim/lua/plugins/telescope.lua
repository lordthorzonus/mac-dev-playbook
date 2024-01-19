return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-ui-select.nvim",
				dependencies = {
					"MunifTanjim/nui.nvim",
					"rcarriga/nvim-notify",
					"debugloop/telescope-undo.nvim",
				},
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
			},
			{
				"stevearc/aerial.nvim",
			},
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

			local telescopeConfig = require("telescope.config")
			--
			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			require("telescope").setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
					file_browser = {
						hijack_netrw = true,
					},
					aerial = {},
				},
			})

			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("undo")
			require("telescope").load_extension("aerial")
			-- require("telescope").load_extension("file_browser")

			-- vim.api.nvim_set_keymap(
			-- 	"n",
			-- 	"<leader>s",
			-- 	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
			-- 	{ noremap = true }
			-- )
			vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
			vim.keymap.set("n", "<leader>pa", "<cmd>Telescope aerial<cr>")
		end,
	},
}
