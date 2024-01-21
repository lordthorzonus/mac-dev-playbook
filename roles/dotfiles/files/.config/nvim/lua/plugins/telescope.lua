local function initialize_keymaps()
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	vim.keymap.set("n", "<leader>e", function()
		builtin.buffers({
			sort_lastused = true,
			ignore_current_buffer = true,
			sort_mru = true,
			sort_order = "descending",
		})
	end, {})
	vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
	vim.keymap.set("n", "<leader>pa", "<cmd>Telescope aerial<cr>")
	vim.keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<cr>")
end

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
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
		},
		config = function()
			local telescopeConfig = require("telescope.config")
			initialize_keymaps()
			--
			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--smart-case")
			table.insert(vimgrep_arguments, "--line-number")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			require("telescope").setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--line-number",
							"--smart-case",
							"--glob",
							"!**/.git/*",
						},
					},
					lsp_references = {
						initial_mode = "normal",
						show_line = false,
					},

					lsp_document_symbols = {
						initial_mode = "normal",
						show_line = false,
					},

					lsp_definitions = {
						initial_mode = "normal",
						show_line = false,
					},

					git_branches = {
						initial_mode = "normal",
						previewer = false,
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
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
			})

			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("undo")
			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")

			-- require("telescope").load_extension("file_browser")

			-- vim.api.nvim_set_keymap(
			-- 	"n",
			-- 	"<leader>s",
			-- 	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
			-- 	{ noremap = true }
			-- )
		end,
	},
}
