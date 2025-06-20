-- Workaround for truncating long TypeScript inlay hints.
-- TODO: Remove this if https://github.com/neovim/neovim/issues/27240 gets addressed.
local methods = vim.lsp.protocol.Methods
local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
local max_inlay_hint_length = 30
vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client and client.name == "typescript-tools" then
		result = vim.iter(result)
			:map(function(hint)
				local label = hint.label ---@type string
				if label:len() >= max_inlay_hint_length then
					label = label:sub(1, max_inlay_hint_length - 1) .. "..."
				end
				hint.label = label
				return hint
			end)
			:totable()
	end

	inlay_hint_handler(err, result, ctx, config)
end

return {
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup({
				commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
				autocmd = { enable = false }, -- Enable the inlay hints on `LspAttach` event
			})

			vim.keymap.set("n", "<leader>th", function()
				vim.cmd("InlayHintsToggle")
			end)
		end,
	},
}
