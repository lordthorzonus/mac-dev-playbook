return {
	{
		"neovim/nvim-lspconfig",
		version = false,
		dependencies = {
			{
				"williamboman/mason.nvim",
				version = false,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				version = false,
			},
		},
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"eslint",
					"rust_analyzer",
					"ansiblels",
					"lua_ls",
					"gopls",
					"spectral",
					"dockerls",
					"docker_compose_language_service",
					"kotlin_language_server",
					"marksman",
					"sqlls",
					"tailwindcss",
					"tflint",
					"yamlls",
					"jsonls",
					"vimls",
				},
			})

			-- Setup LSP capabilities for blink.cmp
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Configure all LSP servers with blink.cmp capabilities
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Setup diagnostic configuration
			vim.diagnostic.config({
				signs = true,
				virtual_lines = false,
				virtual_text = {
					source = "if_many",
				},
				severity_sort = true,
				underline = true,
				update_in_insert = true,
				float = {
					focusable = true,
					border = "single",
				},
			})

			-- LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, remap = false }
					local telescope = require("telescope.builtin")
					vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>vws", telescope.lsp_workspace_symbols, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set(
						{ "n", "v" },
						"<C-Enter>",
						vim.lsp.buf.code_action,
						{ buffer = event.buf, remap = true }
					)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>vrr", telescope.lsp_references, opts)
					vim.keymap.set("n", "gr", telescope.lsp_references, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<C-h>", vim.diagnostic.open_float, { buffer = event.buf, remap = true })
					vim.keymap.set("n", "<leader>fo", function()
						vim.lsp.buf.format()
					end, opts)
					vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
					vim.keymap.set("n", "<leader>ic", telescope.lsp_incoming_calls, opts)
					vim.keymap.set("n", "<leader>oc", telescope.lsp_outgoing_calls, opts)
					vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				end,
			})
		end,
	},
}
