return {
	{
		"lewis6991/gitsigns.nvim",
		version = false,
		opts = {
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>ga", gs.toggle_current_line_blame)
				map("n", "<leader>hd", gs.diffthis)
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>hs", gs.stage_hunk)
				map("n", "<leader>hS", gs.stage_buffer)
			end,
		},
	},
}
