local function open_as_float(win_id)
	-- Get the dimensions of the screen
	local width = vim.fn.winwidth(0)
	local height = vim.fn.winheight(0)

	-- Calculate the position to center the floating window
	local win_width = 120 -- Replace with your desired width
	local win_height = 30 -- Replace with your desired height
	local row = math.floor((height - win_height) / 2)
	local col = math.floor((width - win_width) / 2)

	vim.api.nvim_win_set_config(win_id, {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "single",
	})
end

local function initialize_keymaps()
	vim.keymap.set("n", "<leader>r", function()
		require("neotest").run.run_last()
	end, { desc = "Run Last Test" })

	vim.keymap.set("n", "<leader>td", function()
		require("neotest").run.run_last({ strategy = "dap" })
	end, { desc = "Debug Last Test" })

	vim.keymap.set("n", "<S-C-r>", function()
		require("neotest").run.run()
	end, { desc = "Run Nearest Test" })

	vim.keymap.set("n", "<leader>tn", function()
		require("neotest").run.run()
	end, { desc = "Run Nearest Test" })

	vim.keymap.set("n", "<leader>ts", function()
		require("neotest").summary.toggle()
		local win = vim.fn.bufwinid("Neotest Summary")
		if win > -1 then
			vim.api.nvim_set_current_win(win)
		end
	end, { desc = "Open Test Summary" })

	vim.keymap.set("n", "<leader>to", function()
		require("neotest").output.open({ enter = true, auto_close = true })
	end, { desc = "Show Output" })

	vim.keymap.set("n", "<leader>tO", function()
		require("neotest").output_panel.toggle()
	end, { desc = "Toggle Output Panel" })
end

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-neotest/neotest-jest" },
			"marilari88/neotest-vitest",
			"https://github.com/rouge8/neotest-rust",
			"nvim-neotest/neotest-go",
		},
		config = function()
			initialize_keymaps()

			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			require("neotest").setup({
				summary = {
					open = "topleft vertical 40sp [NeotestSummary]botright float 60% [NeotestSummary]",
				},
				adapters = {
					require("neotest-go"),
					require("neotest-rust"),
					require("neotest-jest")({
						jestCommand = "./node_modules/.bin/jest",
						jestConfigFile = "jest.config.ts",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
	},
}
