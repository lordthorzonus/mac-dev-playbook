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
				dependecies = {
					"hrsh7th/cmp-nvim-lsp",
				},
			},
			{
				"hrsh7th/nvim-cmp",
				version = false,
			},
			{
				"L3MON4D3/LuaSnip",
			},
			{
				"folke/neodev.nvim",
				version = false,
				opts = {},
			},
		},
		config = function()
			require("neodev").setup({})

			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_setup = function(server)
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
					inlay_hints = {
						enabled = true,
					},
				})
			end

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"eslint",
					"rust_analyzer",
					"ansiblels",
					"lua_ls",
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
				handlers = {
					default_setup,
					lua_ls = require("lspconfig").lua_ls.setup({
						capabilities = lsp_capabilities,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					}),
				},
			})

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
				},
				mapping = cmp.mapping.preset.insert({
					-- Enter key confirms completion item
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-Tab>"] = nil,
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					-- Ctrl + space triggers completion menu
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = true,
				float = {
					focuasable = false,
					border = "single",
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, remap = false }

					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, opts)
					vim.keymap.set("n", "gD", function()
						vim.lsp.buf.declaration()
					end, opts)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, opts)
					vim.keymap.set("n", "<leader>vws", function()
						vim.lsp.buf.workspace_symbol()
					end, opts)
					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.goto_next()
					end, opts)
					vim.keymap.set("n", "<M-Enter>", function()
						vim.lsp.buf.code_action()
					end, { buffer = event.buf, remap = true })
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.goto_prev()
					end, opts)
					vim.keymap.set("n", "<leader>vca", function()
						vim.lsp.buf.code_action()
					end, opts)
					vim.keymap.set("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end, opts)
					vim.keymap.set("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end, opts)
					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
					vim.keymap.set("n", "<C-h>", function()
						vim.diagnostic.open_float()
					end, { buffer = event.buf, remap = true })
					vim.keymap.set("n", "<leader>vws", function()
						vim.lsp.buf.workspace_symbol()
					end, opts)
					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end, opts)
					vim.keymap.set("n", "<leader>t", ":lua vim.lsp.buf.code_action()<CR>")
					vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.formatting()<CR>")
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
				end,
			})
		end,
	},
}
