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
			local cmp_kinds = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			}

			cmp.setup({
				window = {
					border = "single",
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- Enter key confirms completion item
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-Tab>"] = nil,
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
					["<Down>"] = cmp.mapping.select_next_item(cmp_select),
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
					local telescope = require("telescope.builtin")
					vim.keymap.set("n", "gd", function()
						telescope.lsp_definitions()
					end, opts)
					vim.keymap.set("n", "gD", function()
						telescope.lsp_declarations()
					end, opts)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, opts)
					vim.keymap.set("n", "<leader>vws", function()
						telescope.lsp_workspace_symbols()
					end, opts)
					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.goto_next()
					end, opts)
					vim.keymap.set("n", "<C-Enter>", function()
						vim.lsp.buf.code_action()
					end, { buffer = event.buf, remap = true })
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.goto_prev()
					end, opts)
					vim.keymap.set("n", "<leader>vca", function()
						vim.lsp.buf.code_action()
					end, opts)
					vim.keymap.set("n", "<leader>vrr", function()
						telescope.lsp_references()
					end, opts)
					vim.keymap.set("n", "gr", function()
						telescope.lsp_references()
					end, opts)
					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)
					vim.keymap.set("n", "<C-h>", function()
						vim.diagnostic.open_float()
					end, { buffer = event.buf, remap = true })
					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end, opts)
					vim.keymap.set("n", "<leader>t", ":lua vim.lsp.buf.code_action()<CR>")
					vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>")
					vim.keymap.set("n", "gi", function()
						telescope.lsp_implementations()
					end, opts)
					vim.keymap.set("n", "<leader>ic", function()
						telescope.lsp_incoming_calls()
					end)

					vim.keymap.set("n", "<leader>oc", function()
						telescope.lsp_outgoing_calls()
					end)
				end,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			breadcrumbs = {
				enable = false,
			},
			outline = {
				layout = "float",
				keys = {
					jump = "e",
					toggle_or_jump = "<cr>",
					quit = "<esc>",
				},
				detail = false,
			},
			lightbulb = {
				enable = false,
				sign = false,
				enable_in_insert = false,
			},
			callhierarchy = {
				keys = {
					quit = "<esc>",
				},
			},
			symbol_in_winbar = {
				enable = false,
			},
			rename = {
				enable = true,
				keymaps = {
					quit = "<esc>",
				},
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function(_, opts)
			local lspsaga = require("lspsaga")
			lspsaga.setup(opts)

			vim.keymap.set("n", "<leader>vrn", function()
				vim.cmd("Lspsaga rename")
			end)

			vim.keymap.set("n", "<C-s>", function()
				vim.cmd("Lspsaga outline")
			end)
		end,
	},
}
